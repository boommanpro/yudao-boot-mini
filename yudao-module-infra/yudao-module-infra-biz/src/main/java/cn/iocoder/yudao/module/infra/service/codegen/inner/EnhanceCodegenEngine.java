package cn.iocoder.yudao.module.infra.service.codegen.inner;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.extra.template.TemplateConfig;
import cn.hutool.extra.template.TemplateEngine;
import cn.hutool.extra.template.engine.velocity.VelocityEngine;
import cn.hutool.system.SystemUtil;
import cn.iocoder.yudao.framework.common.util.collection.CollectionUtils;
import cn.iocoder.yudao.framework.common.util.string.StrUtils;
import cn.iocoder.yudao.module.infra.dal.dataobject.codegen.CodegenColumnDO;
import cn.iocoder.yudao.module.infra.dal.dataobject.codegen.CodegenTableDO;
import cn.iocoder.yudao.module.infra.enums.codegen.CodegenFrontTypeEnum;
import cn.iocoder.yudao.module.infra.enums.codegen.CodegenSceneEnum;
import cn.iocoder.yudao.module.infra.enums.codegen.CodegenTemplateTypeEnum;
import cn.iocoder.yudao.module.infra.framework.codegen.config.CodegenProperties;
import cn.iocoder.yudao.module.ucg.dal.dataobject.codetemplate.CodeTemplateDO;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectVariableDO;
import cn.iocoder.yudao.module.ucg.service.codetemplate.CodeTemplateService;
import com.google.common.annotations.VisibleForTesting;
import com.google.common.collect.Maps;
import lombok.Setter;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.*;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import static cn.hutool.core.map.MapUtil.getStr;
import static cn.hutool.core.text.CharSequenceUtil.*;

/**
 * 代码生成的引擎，用于具体生成代码
 * 目前基于 {@link org.apache.velocity.app.Velocity} 模板引擎实现
 * <p>
 * 考虑到 Java 模板引擎的框架非常多，Freemarker、Velocity、Thymeleaf 等等，所以我们采用 hutool 封装的 {@link cn.hutool.extra.template.Template} 抽象
 *
 * @author 芋道源码
 */
@Component
public class EnhanceCodegenEngine {

    @Resource
    private CodeTemplateService codeTemplateService;

    @Resource
    private CodegenProperties codegenProperties;

    /**
     * 是否使用 jakarta 包，用于解决 Spring Boot 2.X 和 3.X 的兼容性问题
     * <p>
     * true  - 使用 jakarta.validation.constraints.*
     * false - 使用 javax.validation.constraints.*
     */
    @Setter // 允许设置的原因，是因为单测需要手动改变
    private Boolean jakartaEnable;

    /**
     * 模板引擎，由 hutool 实现
     */
    private final TemplateEngine templateEngine;
    /**
     * 全局通用变量映射
     */
    private final Map<String, Object> globalBindingMap = new HashMap<>();

    public EnhanceCodegenEngine() {
        TemplateConfig config = new TemplateConfig();
        this.templateEngine = new VelocityEngine(config);
        // 设置 javaxEnable，按照是否使用 JDK17 来判断
        this.jakartaEnable = SystemUtil.getJavaInfo().isJavaVersionAtLeast(1700); // 17.00 * 100
    }

    @PostConstruct
    @VisibleForTesting
    void initGlobalBindingMap() {
        globalBindingMap.put("baseDOFields", CodegenBuilder.BASE_DO_FIELDS);
    }

    /**
     * 生成代码
     *
     * @param table          表定义
     * @param columns        table 的字段定义数组
     * @param subTables      子表数组，当且仅当主子表时使用
     * @param subColumnsList subTables 的字段定义数组
     * @return 生成的代码，key 是路径，value 是对应代码
     */
    public Map<String, String> execute(CodegenTableDO table, List<CodegenColumnDO> columns,
                                       List<CodegenTableDO> subTables, List<List<CodegenColumnDO>> subColumnsList) {
        // 1.1 初始化 bindMap 上下文
        Map<String, Object> bindingMap = initBindingMap(table, columns, subTables, subColumnsList);
        // 1.2 获得模版
        List<CodeTemplateDO> templatess = getTemplates(table.getFrontType());

        // 2. 执行生成
        Map<String, String> result = Maps.newLinkedHashMapWithExpectedSize(templatess.size()); // 有序
        templatess.forEach((template) -> {
            // 2.1 特殊：主子表专属逻辑
            String vmPath = template.getOriginalPath();
            String filePath = template.getFilePathExpression();
            String fileContent = template.getTemplateContent();

            if (isSubTemplate(vmPath)) {
                generateSubCode(table, subTables, result, vmPath, filePath, fileContent, bindingMap);
                return;
                // 2.2 特殊：树表专属逻辑
            } else {
                if (isPageReqVOTemplate(vmPath)) {
                    // 减少多余的类生成，例如说 PageVO.java 类
                    if (CodegenTemplateTypeEnum.isTree(table.getTemplateType())) {
                        return;
                    }
                } else if (isListReqVOTemplate(vmPath)) {
                    // 减少多余的类生成，例如说 ListVO.java 类
                    if (!CodegenTemplateTypeEnum.isTree(table.getTemplateType())) {
                        return;
                    }
                }
            }
            // 2.3 默认生成
            generateCode(result, vmPath, filePath, fileContent, bindingMap);
        });
        return result;
    }

    private void generateCode(Map<String, String> result, String vmPath,
                              String filePath, String fileContent, Map<String, Object> bindingMap) {
        filePath = formatFilePath(filePath, bindingMap);

        String content = templateEngine.getTemplate(fileContent).render(bindingMap);
        // 格式化代码
        content = prettyCode(content);
        result.put(filePath, content);
    }

    private void generateSubCode(CodegenTableDO table, List<CodegenTableDO> subTables,
                                 Map<String, String> result, String vmPath,
                                 String filePath, String fileContent, Map<String, Object> bindingMap) {
        // 没有子表，所以不生成
        if (CollUtil.isEmpty(subTables)) {
            return;
        }
        // 主子表的模式匹配。目的：过滤掉个性化的模版
        if (vmPath.contains("_normal")
                && ObjectUtil.notEqual(table.getTemplateType(), CodegenTemplateTypeEnum.MASTER_NORMAL.getType())) {
            return;
        }
        if (vmPath.contains("_erp")
                && ObjectUtil.notEqual(table.getTemplateType(), CodegenTemplateTypeEnum.MASTER_ERP.getType())) {
            return;
        }
        if (vmPath.contains("_inner")
                && ObjectUtil.notEqual(table.getTemplateType(), CodegenTemplateTypeEnum.MASTER_INNER.getType())) {
            return;
        }

        // 逐个生成
        for (int i = 0; i < subTables.size(); i++) {
            bindingMap.put("subIndex", i);
            generateCode(result, vmPath, filePath, fileContent, bindingMap);
        }
        bindingMap.remove("subIndex");
    }

    /**
     * 格式化生成后的代码
     * <p>
     * 因为尽量让 vm 模版简单，所以统一的处理都在这个方法。
     * 如果不处理，Vue 的 Pretty 格式校验可能会报错
     *
     * @param content 格式化前的代码
     * @return 格式化后的代码
     */
    private String prettyCode(String content) {
        // Vue 界面：去除字段后面多余的 , 逗号，解决前端的 Pretty 代码格式检查的报错
        content = content.replaceAll(",\n}", "\n}").replaceAll(",\n  }", "\n  }");
        // Vue 界面：去除多的 dateFormatter，只有一个的情况下，说明没使用到
        if (StrUtil.count(content, "dateFormatter") == 1) {
            content = StrUtils.removeLineContains(content, "dateFormatter");
        }
        // Vue2 界面：修正 $refs
        if (StrUtil.count(content, "this.refs") >= 1) {
            content = content.replace("this.refs", "this.$refs");
        }
        // Vue 界面：去除多的 dict 相关，只有一个的情况下，说明没使用到
        if (StrUtil.count(content, "getIntDictOptions") == 1) {
            content = content.replace("getIntDictOptions, ", "");
        }
        if (StrUtil.count(content, "getStrDictOptions") == 1) {
            content = content.replace("getStrDictOptions, ", "");
        }
        if (StrUtil.count(content, "getBoolDictOptions") == 1) {
            content = content.replace("getBoolDictOptions, ", "");
        }
        if (StrUtil.count(content, "DICT_TYPE.") == 0) {
            content = StrUtils.removeLineContains(content, "DICT_TYPE");
        }
        return content;
    }

    private Map<String, Object> initBindingMap(CodegenTableDO table, List<CodegenColumnDO> columns,
                                               List<CodegenTableDO> subTables, List<List<CodegenColumnDO>> subColumnsList) {
        // 创建 bindingMap
        Map<String, Object> bindingMap = new HashMap<>(globalBindingMap);
        bindingMap.put("table", table);
        bindingMap.put("columns", columns);
        bindingMap.put("primaryColumn", CollectionUtils.findFirst(columns, CodegenColumnDO::getPrimaryKey)); // 主键字段
        bindingMap.put("sceneEnum", CodegenSceneEnum.valueOf(table.getScene()));

        // className 相关
        // 去掉指定前缀，将 TestDictType 转换成 DictType. 因为在 create 等方法后，不需要带上 Test 前缀
        String simpleClassName = equalsAnyIgnoreCase(table.getClassName(), table.getModuleName()) ? table.getClassName()
                : removePrefix(table.getClassName(), upperFirst(table.getModuleName()));
        bindingMap.put("simpleClassName", simpleClassName);
        bindingMap.put("simpleClassName_underlineCase", toUnderlineCase(simpleClassName)); // 将 DictType 转换成 dict_type
        bindingMap.put("classNameVar", lowerFirst(simpleClassName)); // 将 DictType 转换成 dictType，用于变量
        // 将 DictType 转换成 dict-type
        String simpleClassNameStrikeCase = toSymbolCase(simpleClassName, '-');
        bindingMap.put("simpleClassName_strikeCase", simpleClassNameStrikeCase);
        // permission 前缀
        bindingMap.put("permissionPrefix", table.getModuleName() + ":" + simpleClassNameStrikeCase);

        // 特殊：树表专属逻辑
        if (CodegenTemplateTypeEnum.isTree(table.getTemplateType())) {
            CodegenColumnDO treeParentColumn = CollUtil.findOne(columns,
                    column -> Objects.equals(column.getId(), table.getTreeParentColumnId()));
            bindingMap.put("treeParentColumn", treeParentColumn);
            bindingMap.put("treeParentColumn_javaField_underlineCase", toUnderlineCase(treeParentColumn.getJavaField()));
            CodegenColumnDO treeNameColumn = CollUtil.findOne(columns,
                    column -> Objects.equals(column.getId(), table.getTreeNameColumnId()));
            bindingMap.put("treeNameColumn", treeNameColumn);
            bindingMap.put("treeNameColumn_javaField_underlineCase", toUnderlineCase(treeNameColumn.getJavaField()));
        }

        // 特殊：主子表专属逻辑
        if (CollUtil.isNotEmpty(subTables)) {
            // 创建 bindingMap
            bindingMap.put("subTables", subTables);
            bindingMap.put("subColumnsList", subColumnsList);
            List<CodegenColumnDO> subPrimaryColumns = new ArrayList<>();
            List<CodegenColumnDO> subJoinColumns = new ArrayList<>();
            List<String> subJoinColumnStrikeCases = new ArrayList<>();
            List<String> subSimpleClassNames = new ArrayList<>();
            List<String> subClassNameVars = new ArrayList<>();
            List<String> simpleClassNameUnderlineCases = new ArrayList<>();
            List<String> subSimpleClassNameStrikeCases = new ArrayList<>();
            for (int i = 0; i < subTables.size(); i++) {
                CodegenTableDO subTable = subTables.get(i);
                List<CodegenColumnDO> subColumns = subColumnsList.get(i);
                subPrimaryColumns.add(CollectionUtils.findFirst(subColumns, CodegenColumnDO::getPrimaryKey)); //
                CodegenColumnDO subColumn = CollectionUtils.findFirst(subColumns, // 关联的字段
                        column -> Objects.equals(column.getId(), subTable.getSubJoinColumnId()));
                subJoinColumns.add(subColumn);
                subJoinColumnStrikeCases.add(toSymbolCase(subColumn.getJavaField(), '-')); // 将 DictType 转换成 dict-type
                // className 相关
                String subSimpleClassName = removePrefix(subTable.getClassName(), upperFirst(subTable.getModuleName()));
                subSimpleClassNames.add(subSimpleClassName);
                simpleClassNameUnderlineCases.add(toUnderlineCase(subSimpleClassName)); // 将 DictType 转换成 dict_type
                subClassNameVars.add(lowerFirst(subSimpleClassName)); // 将 DictType 转换成 dictType，用于变量
                subSimpleClassNameStrikeCases.add(toSymbolCase(subSimpleClassName, '-')); // 将 DictType 转换成 dict-type
            }
            bindingMap.put("subPrimaryColumns", subPrimaryColumns);
            bindingMap.put("subJoinColumns", subJoinColumns);
            bindingMap.put("subJoinColumn_strikeCases", subJoinColumnStrikeCases);
            bindingMap.put("subSimpleClassNames", subSimpleClassNames);
            bindingMap.put("simpleClassNameUnderlineCases", simpleClassNameUnderlineCases);
            bindingMap.put("subClassNameVars", subClassNameVars);
            bindingMap.put("subSimpleClassName_strikeCases", subSimpleClassNameStrikeCases);
        }
        List<ProjectVariableDO> variableList = codeTemplateService.queryVariables();
        variableList.stream()
                .sorted(Comparator.comparingInt(ProjectVariableDO::getExecuteOrder))
                .forEach(new Consumer<ProjectVariableDO>() {
                    @Override
                    public void accept(ProjectVariableDO v) {
                        if (v.getExpressionType().equals("SP_EL_TEMPLATE")) {
                            bindingMap.put(v.getVariableName(), SpringExpressionParser.getInstance().getTemplateValue(v.getVariableExpression(), bindingMap));
                        }else {
                            bindingMap.put(v.getVariableName(), SpringExpressionParser.getInstance().getValue(v.getVariableExpression(), bindingMap));
                        }
                    }
                });

        return bindingMap;
    }

    private List<CodeTemplateDO> getTemplates(Integer frontType) {
        List<CodeTemplateDO> allTemplates = codeTemplateService.loadCodeTemplateByFrontType(CodegenFrontTypeEnum.getType(frontType).name());
        // 如果禁用单元测试，则移除对应的模版
        if (Boolean.FALSE.equals(codegenProperties.getUnitTestEnable())) {
            return allTemplates.stream().filter(codeTemplateDO -> !codeTemplateDO.getOriginalPath().contains("test/serviceTest") && !codeTemplateDO.getOriginalPath().contains("codegen/sql/h2.vm")).collect(Collectors.toList());
        }
        return allTemplates;
    }

    @SuppressWarnings("unchecked")
    private String formatFilePath(String filePath, Map<String, Object> bindingMap) {
        // 特殊：主子表专属逻辑
        Integer subIndex = (Integer) bindingMap.get("subIndex");
        bindingMap.put("subIndex", subIndex);
        filePath = SpringExpressionParser.getInstance().getTemplateValue(filePath, bindingMap);
        bindingMap.remove("subIndex");
        return filePath;
    }


    private static boolean isSubTemplate(String path) {
        return path.contains("_sub");
    }

    private static boolean isPageReqVOTemplate(String path) {
        return path.contains("pageReqVO");
    }

    private static boolean isListReqVOTemplate(String path) {
        return path.contains("listReqVO");
    }

}
