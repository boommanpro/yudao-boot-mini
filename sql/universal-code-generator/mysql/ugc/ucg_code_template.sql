create table ucg_code_template
(
    id                   bigint auto_increment comment '编号，自增，唯一标识一个代码模板',
    project_id           bigint                                                           not null comment '项目id',
    template_name        varchar(128)                                                     not null comment '模板名称，不能为空',
    template_description varchar(256)                                                     null comment '模板描述',
    template_type        varchar(128)                                                     not null comment '模板类型 SERVER  FRONT',
    template_type_value  varchar(128)                                                     not null comment '模板类型值',
    file_type            varchar(128)                                                     not null comment '文件类型，标识模板的文件类型，不能为空',
    file_path_expression varchar(512)                                                     not null comment '文件路径，长文本类型，标识模板文件的存储路径，不能为空',
    original_path        varchar(512)                                                     null comment '原始路径',
    template_content     longtext                                                         not null comment '模板内容，长文本类型，存储模板的具体内容，不能为空',
    creator              varchar(64) collate utf8mb4_unicode_ci default ''                null comment '创建者，默认为空字符串',
    create_time          datetime                               default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前时间戳',
    updater              varchar(64) collate utf8mb4_unicode_ci default ''                null comment '更新者，默认为空字符串',
    update_time          datetime                               default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间，默认为当前时间戳，更新记录时自动更新',
    deleted              bit                                    default b'0'              not null comment '是否删除，位类型，默认为0（未删除）',
    primary key (id, project_id)
)
    comment '存储代码模板的基本信息';

INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (2, 1, 'PageReqVO', '分页请求VO', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/vo/${sceneEnum.prefixClass}${table.className}PageReqVO.java', 'codegen/java/controller/vo/pageReqVO.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo;

import lombok.*;
import java.util.*;
import io.swagger.v3.oas.annotations.media.Schema;
import ${PageParamClassName};
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#break
#end
#end
## 处理 LocalDateTime 字段的引入
#foreach ($column in $columns)
#if (${column.listOperationCondition} && ${column.javaType} == "LocalDateTime")
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;

import static ${DateUtilsClassName}.FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND;
#break
#end
#end
## 字段模板
#macro(columnTpl $prefix $prefixStr)
    @Schema(description = "${prefixStr}${column.columnComment}"#if ("$!column.example" != ""), example = "${column.example}"#end)
    private ${column.javaType}#if ("$!prefix" != "") ${prefix}${JavaField}#else ${column.javaField}#end;
#end

@Schema(description = "${sceneEnum.name} - ${table.classComment}分页 Request VO")
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class ${sceneEnum.prefixClass}${table.className}PageReqVO extends PageParam {

#foreach ($column in $columns)
#if (${column.listOperation})##查询操作
#if (${column.listOperationCondition} == "BETWEEN")## 情况一，Between 的时候
    @Schema(description = "${column.columnComment}"#if ("$!column.example" != ""), example = "${column.example}"#end)
    @DateTimeFormat(pattern = FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND)
    private ${column.javaType}[] ${column.javaField};
#else##情况二，非 Between 的时间
    #columnTpl(\'\', \'\')
#end

#end
#end
}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:22', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (3, 1, 'ListReqVO', '全部列表请求VO', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/vo/${sceneEnum.prefixClass}${table.className}ListReqVO.java', 'codegen/java/controller/vo/listReqVO.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo;

import lombok.*;
import java.util.*;
import io.swagger.v3.oas.annotations.media.Schema;
import ${PageParamClassName};
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#break
#end
#end
## 处理 LocalDateTime 字段的引入
#foreach ($column in $columns)
#if (${column.listOperation} && ${column.javaType} == "LocalDateTime")
import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;

import static ${DateUtilsClassName}.FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND;
#break
#end
#end
## 字段模板
#macro(columnTpl $prefix $prefixStr)
    @Schema(description = "${prefixStr}${column.columnComment}"#if ("$!column.example" != ""), example = "${column.example}"#end)
    private ${column.javaType}#if ("$!prefix" != "") ${prefix}${JavaField}#else ${column.javaField}#end;
#end

@Schema(description = "${sceneEnum.name} - ${table.classComment}列表 Request VO")
@Data
public class ${sceneEnum.prefixClass}${table.className}ListReqVO {

#foreach ($column in $columns)
#if (${column.listOperation})##查询操作
#if (${column.listOperationCondition} == "BETWEEN")## 情况一，Between 的时候
    @Schema(description = "${column.columnComment}"#if ("$!column.example" != ""), example = "${column.example}"#end)
    @DateTimeFormat(pattern = FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND)
    private ${column.javaType}[] ${column.javaField};
#else##情况二，非 Between 的时间
    #columnTpl(\'\', \'\')
#end

#end
#end
}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:25', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (4, 1, 'RespVO', '返回值VO', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/vo/${sceneEnum.prefixClass}${table.className}RespVO.java', 'codegen/java/controller/vo/respVO.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import java.util.*;
## 处理 BigDecimal 字段的引入
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#break
#end
#end
## 处理 LocalDateTime 字段的引入
#foreach ($column in $columns)
#if (${column.listOperationResult} && ${column.javaType} == "LocalDateTime")
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;
#break
#end
#end
## 处理 Excel 导出
import com.alibaba.excel.annotation.*;
#foreach ($column in $columns)
#if ("$!column.dictType" != "")## 有设置数据字典
import ${DictFormatClassName};
import ${DictConvertClassName};
#break
#end
#end

@Schema(description = "${sceneEnum.name} - ${table.classComment} Response VO")
@Data
@ExcelIgnoreUnannotated
public class ${sceneEnum.prefixClass}${table.className}RespVO {

## 逐个处理字段
#foreach ($column in $columns)
#if (${column.listOperationResult})
## 1. 处理 Swagger 注解
    @Schema(description = "${column.columnComment}"#if (!${column.nullable}), requiredMode = Schema.RequiredMode.REQUIRED#end#if ("$!column.example" != ""), example = "${column.example}"#end)
## 2. 处理 Excel 导出
#if ("$!column.dictType" != "")##处理枚举值
    @ExcelProperty(value = "${column.columnComment}", converter = DictConvert.class)
    @DictFormat("${column.dictType}") // TODO 代码优化：建议设置到对应的 DictTypeConstants 枚举类中
#else
    @ExcelProperty("${column.columnComment}")
#end
## 3. 处理字段定义
    private ${column.javaType} ${column.javaField};

#end
#end
}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:27', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (5, 1, 'SaveReqVO', '保存请求VO', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/vo/${sceneEnum.prefixClass}${table.className}SaveReqVO.java', 'codegen/java/controller/vo/saveReqVO.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import java.util.*;
import ${jakartaPackage}.validation.constraints.*;
## 处理 BigDecimal 字段的引入
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#break
#end
#end
## 处理 LocalDateTime 字段的引入
#foreach ($column in $columns)
#if ((${column.createOperation} || ${column.updateOperation}) && ${column.javaType} == "LocalDateTime")
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;
#break
#end
#end
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
#end

@Schema(description = "${sceneEnum.name} - ${table.classComment}新增/修改 Request VO")
@Data
public class ${sceneEnum.prefixClass}${table.className}SaveReqVO {

## 逐个处理字段
#foreach ($column in $columns)
#if (${column.createOperation} || ${column.updateOperation})
## 1. 处理 Swagger 注解
    @Schema(description = "${column.columnComment}"#if (!${column.nullable}), requiredMode = Schema.RequiredMode.REQUIRED#end#if ("$!column.example" != ""), example = "${column.example}"#end)
## 2. 处理 Validator 参数校验
#if (!${column.nullable} && !${column.primaryKey})
#if (${column.javaType} == \'String\')
    @NotEmpty(message = "${column.columnComment}不能为空")
#else
    @NotNull(message = "${column.columnComment}不能为空")
#end
#end
## 3. 处理字段定义
    private ${column.javaType} ${column.javaField};

#end
#end
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11 )
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
    #if ( $subTable.subJoinMany)
    @Schema(description = "${subTable.classComment}列表")
    private List<${subTable.className}DO> ${subClassNameVars.get($index)}s;

    #else
    @Schema(description = "${subTable.classComment}")
    private ${subTable.className}DO ${subClassNameVars.get($index)};

    #end
#end
#end
}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:28', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (6, 1, 'controller', 'controller', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/${sceneEnum.prefixClass}${table.className}Controller.java', 'codegen/java/controller/controller.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName};

import org.springframework.web.bind.annotation.*;
import ${jakartaPackage}.annotation.Resource;
import org.springframework.validation.annotation.Validated;
#if ($sceneEnum.scene == 1)import org.springframework.security.access.prepost.PreAuthorize;#end

import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Operation;

import ${jakartaPackage}.validation.constraints.*;
import ${jakartaPackage}.validation.*;
import ${jakartaPackage}.servlet.http.*;
import java.util.*;
import java.io.IOException;

import ${PageParamClassName};
import ${PageResultClassName};
import ${CommonResultClassName};
import ${BeanUtils};
import static ${CommonResultClassName}.success;

import ${ExcelUtilsClassName};

import ${ApiAccessLogClassName};
import static ${OperateTypeEnumClassName}.*;

import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
#end
import ${basePackage}.module.${table.moduleName}.service.${table.businessName}.${table.className}Service;

@Tag(name = "${sceneEnum.name} - ${table.classComment}")
@RestController
##二级的 businessName 暂时不算在 HTTP 路径上，可以根据需要写
@RequestMapping("/${table.moduleName}/${simpleClassName_strikeCase}")
@Validated
public class ${sceneEnum.prefixClass}${table.className}Controller {

    @Resource
    private ${table.className}Service ${classNameVar}Service;

    @PostMapping("/create")
    @Operation(summary = "创建${table.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:create\')")
#end
    public CommonResult<${primaryColumn.javaType}> create${simpleClassName}(@Valid @RequestBody ${sceneEnum.prefixClass}${table.className}SaveReqVO createReqVO) {
        return success(${classNameVar}Service.create${simpleClassName}(createReqVO));
    }

    @PutMapping("/update")
    @Operation(summary = "更新${table.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:update\')")
#end
    public CommonResult<Boolean> update${simpleClassName}(@Valid @RequestBody ${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO) {
        ${classNameVar}Service.update${simpleClassName}(updateReqVO);
        return success(true);
    }

    @DeleteMapping("/delete")
    @Operation(summary = "删除${table.classComment}")
    @Parameter(name = "id", description = "编号", required = true)
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:delete\')")
#end
    public CommonResult<Boolean> delete${simpleClassName}(@RequestParam("id") ${primaryColumn.javaType} id) {
        ${classNameVar}Service.delete${simpleClassName}(id);
        return success(true);
    }

    @GetMapping("/get")
    @Operation(summary = "获得${table.classComment}")
    @Parameter(name = "id", description = "编号", required = true, example = "1024")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<${sceneEnum.prefixClass}${table.className}RespVO> get${simpleClassName}(@RequestParam("id") ${primaryColumn.javaType} id) {
        ${table.className}DO ${classNameVar} = ${classNameVar}Service.get${simpleClassName}(id);
        return success(BeanUtils.toBean(${classNameVar}, ${sceneEnum.prefixClass}${table.className}RespVO.class));
    }

#if ( $table.templateType != 2 )
    @GetMapping("/page")
    @Operation(summary = "获得${table.classComment}分页")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<PageResult<${sceneEnum.prefixClass}${table.className}RespVO>> get${simpleClassName}Page(@Valid ${sceneEnum.prefixClass}${table.className}PageReqVO pageReqVO) {
        PageResult<${table.className}DO> pageResult = ${classNameVar}Service.get${simpleClassName}Page(pageReqVO);
        return success(BeanUtils.toBean(pageResult, ${sceneEnum.prefixClass}${table.className}RespVO.class));
    }

## 特殊：树表专属逻辑（树不需要分页接口）
#else
    @GetMapping("/list")
    @Operation(summary = "获得${table.classComment}列表")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<List<${sceneEnum.prefixClass}${table.className}RespVO>> get${simpleClassName}List(@Valid ${sceneEnum.prefixClass}${table.className}ListReqVO listReqVO) {
        List<${table.className}DO> list = ${classNameVar}Service.get${simpleClassName}List(listReqVO);
        return success(BeanUtils.toBean(list, ${sceneEnum.prefixClass}${table.className}RespVO.class));
    }

#end
    @GetMapping("/export-excel")
    @Operation(summary = "导出${table.classComment} Excel")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:export\')")
#end
    @ApiAccessLog(operateType = EXPORT)
#if ( $table.templateType != 2 )
    public void export${simpleClassName}Excel(@Valid ${sceneEnum.prefixClass}${table.className}PageReqVO pageReqVO,
              HttpServletResponse response) throws IOException {
        pageReqVO.setPageSize(PageParam.PAGE_SIZE_NONE);
        List<${table.className}DO> list = ${classNameVar}Service.get${simpleClassName}Page(pageReqVO).getList();
        // 导出 Excel
        ExcelUtils.write(response, "${table.classComment}.xls", "数据", ${sceneEnum.prefixClass}${table.className}RespVO.class,
                        BeanUtils.toBean(list, ${sceneEnum.prefixClass}${table.className}RespVO.class));
    }
## 特殊：树表专属逻辑（树不需要分页接口）
#else
    public void export${simpleClassName}Excel(@Valid ${sceneEnum.prefixClass}${table.className}ListReqVO listReqVO,
              HttpServletResponse response) throws IOException {
        List<${table.className}DO> list = ${classNameVar}Service.get${simpleClassName}List(listReqVO);
        // 导出 Excel
        ExcelUtils.write(response, "${table.classComment}.xls", "数据", ${table.className}RespVO.class,
                        BeanUtils.toBean(list, ${table.className}RespVO.class));
    }
#end

## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subPrimaryColumn = $subPrimaryColumns.get($index))##当前 primary 字段
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
#set ($subSimpleClassName_strikeCase = $subSimpleClassName_strikeCases.get($index))
#set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
#set ($subClassNameVar = $subClassNameVars.get($index))
    // ==================== 子表（$subTable.classComment） ====================

## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )
    @GetMapping("/${subSimpleClassName_strikeCase}/page")
    @Operation(summary = "获得${subTable.classComment}分页")
    @Parameter(name = "${subJoinColumn.javaField}", description = "${subJoinColumn.columnComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<PageResult<${subTable.className}DO>> get${subSimpleClassName}Page(PageParam pageReqVO,
                                                                                        @RequestParam("${subJoinColumn.javaField}") ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return success(${classNameVar}Service.get${subSimpleClassName}Page(pageReqVO, ${subJoinColumn.javaField}));
    }

## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
    #if ( $subTable.subJoinMany )
    @GetMapping("/${subSimpleClassName_strikeCase}/list-by-${subJoinColumn_strikeCase}")
    @Operation(summary = "获得${subTable.classComment}列表")
    @Parameter(name = "${subJoinColumn.javaField}", description = "${subJoinColumn.columnComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<List<${subTable.className}DO>> get${subSimpleClassName}ListBy${SubJoinColumnName}(@RequestParam("${subJoinColumn.javaField}") ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return success(${classNameVar}Service.get${subSimpleClassName}ListBy${SubJoinColumnName}(${subJoinColumn.javaField}));
    }

    #else
    @GetMapping("/${subSimpleClassName_strikeCase}/get-by-${subJoinColumn_strikeCase}")
    @Operation(summary = "获得${subTable.classComment}")
    @Parameter(name = "${subJoinColumn.javaField}", description = "${subJoinColumn.columnComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<${subTable.className}DO> get${subSimpleClassName}By${SubJoinColumnName}(@RequestParam("${subJoinColumn.javaField}") ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return success(${classNameVar}Service.get${subSimpleClassName}By${SubJoinColumnName}(${subJoinColumn.javaField}));
    }

    #end
#end
## 特殊：MASTER_ERP 时，支持单个的新增、修改、删除操作
#if ( $table.templateType == 11 )
    @PostMapping("/${subSimpleClassName_strikeCase}/create")
    @Operation(summary = "创建${subTable.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:create\')")
#end
    public CommonResult<${subPrimaryColumn.javaType}> create${subSimpleClassName}(@Valid @RequestBody ${subTable.className}DO ${subClassNameVar}) {
        return success(${classNameVar}Service.create${subSimpleClassName}(${subClassNameVar}));
    }

    @PutMapping("/${subSimpleClassName_strikeCase}/update")
    @Operation(summary = "更新${subTable.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:update\')")
#end
    public CommonResult<Boolean> update${subSimpleClassName}(@Valid @RequestBody ${subTable.className}DO ${subClassNameVar}) {
        ${classNameVar}Service.update${subSimpleClassName}(${subClassNameVar});
        return success(true);
    }

    @DeleteMapping("/${subSimpleClassName_strikeCase}/delete")
    @Parameter(name = "id", description = "编号", required = true)
    @Operation(summary = "删除${subTable.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:delete\')")
#end
    public CommonResult<Boolean> delete${subSimpleClassName}(@RequestParam("id") ${subPrimaryColumn.javaType} id) {
        ${classNameVar}Service.delete${subSimpleClassName}(id);
        return success(true);
    }

	@GetMapping("/${subSimpleClassName_strikeCase}/get")
	@Operation(summary = "获得${subTable.classComment}")
	@Parameter(name = "id", description = "编号", required = true)
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
	public CommonResult<${subTable.className}DO> get${subSimpleClassName}(@RequestParam("id") ${subPrimaryColumn.javaType} id) {
	    return success(${classNameVar}Service.get${subSimpleClassName}(id));
	}

#end
#end
}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:29', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (7, 1, 'do', '实体类', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/dal/dataobject/${table.businessName}/${table.className}DO.java', 'codegen/java/dal/do.vm', 'package ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName};

import lombok.*;
import java.util.*;
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#end
#if (${column.javaType} == "LocalDateTime")
import java.time.LocalDateTime;
#end
#end
import com.baomidou.mybatisplus.annotation.*;
import ${BaseDOClassName};

/**
 * ${table.classComment} DO
 *
 * @author ${table.author}
 */
@TableName("${table.tableName.toLowerCase()}")
@KeySequence("${table.tableName.toLowerCase()}_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ${table.className}DO extends BaseDO {

## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
    public static final Long ${treeParentColumn_javaField_underlineCase.toUpperCase()}_ROOT = 0L;

#end
#foreach ($column in $columns)
#if (!${baseDOFields.contains(${column.javaField})})##排除 BaseDO 的字段
    /**
     * ${column.columnComment}
    #if ("$!column.dictType" != "")##处理枚举值
     *
     * 枚举 {@link TODO ${column.dictType} 对应的类}
    #end
     */
    #if (${column.primaryKey})##处理主键
    @TableId#if (${column.javaType} == \'String\')(type = IdType.INPUT)#end
    #end
    private ${column.javaType} ${column.javaField};
#end
#end

}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:31', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (8, 1, 'do_sub', '子表实体类', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/dal/dataobject/${table.businessName}/${subTables[subIndex].className}DO.java', 'codegen/java/dal/do_sub.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
package ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName};

import lombok.*;
import java.util.*;
#foreach ($column in $subColumns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#end
#if (${column.javaType} == "LocalDateTime")
import java.time.LocalDateTime;
#end
#end
import com.baomidou.mybatisplus.annotation.*;
import ${BaseDOClassName};

/**
 * ${subTable.classComment} DO
 *
 * @author ${subTable.author}
 */
@TableName("${subTable.tableName.toLowerCase()}")
@KeySequence("${subTable.tableName.toLowerCase()}_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ${subTable.className}DO extends BaseDO {

#foreach ($column in $subColumns)
#if (!${baseDOFields.contains(${column.javaField})})##排除 BaseDO 的字段
    /**
     * ${column.columnComment}
    #if ("$!column.dictType" != "")##处理枚举值
     *
     * 枚举 {@link TODO ${column.dictType} 对应的类}
    #end
     */
    #if (${column.primaryKey})##处理主键
    @TableId#if (${column.javaType} == \'String\')(type = IdType.INPUT)#end
    #end
    private ${column.javaType} ${column.javaField};
#end
#end

}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:32', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (9, 1, 'mapper', 'java mybatis的mapper接口', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/dal/mysql/${table.businessName}/${table.className}Mapper.java', 'codegen/java/dal/mapper.vm', 'package ${basePackage}.module.${table.moduleName}.dal.mysql.${table.businessName};

import java.util.*;

import ${PageResultClassName};
import ${QueryWrapperClassName};
import ${BaseMapperClassName};
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
import org.apache.ibatis.annotations.Mapper;
import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;

## 字段模板
#macro(listCondition)
#foreach ($column in $columns)
#if (${column.listOperation})
#set ($JavaField = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})##首字母大写
#if (${column.listOperationCondition} == "=")##情况一，= 的时候
                .eqIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "!=")##情况二，!= 的时候
                .neIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == ">")##情况三，> 的时候
                .gtIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == ">=")##情况四，>= 的时候
                .geIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "<")##情况五，< 的时候
                .ltIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "<=")##情况五，<= 的时候
                .leIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "LIKE")##情况七，Like 的时候
                .likeIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "BETWEEN")##情况八，Between 的时候
                .betweenIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#end
#end
#end
/**
 * ${table.classComment} Mapper
 *
 * @author ${table.author}
 */
@Mapper
public interface ${table.className}Mapper extends BaseMapperX<${table.className}DO> {

## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
    default PageResult<${table.className}DO> selectPage(${sceneEnum.prefixClass}${table.className}PageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<${table.className}DO>()
			#listCondition()
                .orderByDesc(${table.className}DO::getId));## 大多数情况下，id 倒序

    }
#else
    default List<${table.className}DO> selectList(${sceneEnum.prefixClass}${table.className}ListReqVO reqVO) {
        return selectList(new LambdaQueryWrapperX<${table.className}DO>()
			#listCondition()
                .orderByDesc(${table.className}DO::getId));## 大多数情况下，id 倒序

    }
#end

## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($TreeParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
#set ($TreeNameJavaField = $treeNameColumn.javaField.substring(0,1).toUpperCase() + ${treeNameColumn.javaField.substring(1)})##首字母大写
	default ${table.className}DO selectBy${TreeParentJavaField}And${TreeNameJavaField}(Long ${treeParentColumn.javaField}, String ${treeNameColumn.javaField}) {
	    return selectOne(${table.className}DO::get${TreeParentJavaField}, ${treeParentColumn.javaField}, ${table.className}DO::get${TreeNameJavaField}, ${treeNameColumn.javaField});
	}

    default Long selectCountBy${TreeParentJavaField}(${treeParentColumn.javaType} ${treeParentColumn.javaField}) {
        return selectCount(${table.className}DO::get${TreeParentJavaField}, ${treeParentColumn.javaField});
    }

#end
}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:34', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (10, 1, 'mapper_sub', '子表的java mybatis的mapper接口', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/dal/mysql/${table.businessName}/${subTables[subIndex].className}Mapper.java', 'codegen/java/dal/mapper_sub.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subJoinColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
package ${basePackage}.module.${subTable.moduleName}.dal.mysql.${subTable.businessName};

import java.util.*;

import ${PageResultClassName};
import ${PageParamClassName};
import ${QueryWrapperClassName};
import ${BaseMapperClassName};
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
import org.apache.ibatis.annotations.Mapper;

/**
 * ${subTable.classComment} Mapper
 *
 * @author ${subTable.author}
 */
@Mapper
public interface ${subTable.className}Mapper extends BaseMapperX<${subTable.className}DO> {

## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )
    default PageResult<${subTable.className}DO> selectPage(PageParam reqVO, ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return selectPage(reqVO, new LambdaQueryWrapperX<${subTable.className}DO>()
            .eq(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField})
            .orderByDesc(${subTable.className}DO::getId));## 大多数情况下，id 倒序

    }
## 主表与子表是一对一时 
    #if (!$subTable.subJoinMany)
        default ${subTable.className}DO selectBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return selectOne(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField});
        }
    #end

## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
    #if ( $subTable.subJoinMany)
    default List<${subTable.className}DO> selectListBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return selectList(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField});
    }

    #else
    default ${subTable.className}DO selectBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return selectOne(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField});
    }

    #end
    #end
    default int deleteBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return delete(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField});
    }

}

', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:35', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (11, 1, 'mapper_xml', 'myabtis的xml', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/resources/mapper/${table.businessName}/${table.className}Mapper.xml', 'codegen/java/dal/mapper.xml.vm', '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${basePackage}.module.${table.moduleName}.dal.mysql.${table.businessName}.${table.className}Mapper">

    <!--
        一般情况下，尽可能使用 Mapper 进行 CRUD 增删改查即可。
        无法满足的场景，例如说多表关联查询，才使用 XML 编写 SQL。
        代码生成器暂时只生成 Mapper XML 文件本身，更多推荐 MybatisX 快速开发插件来生成查询。
        文档可见：https://www.iocoder.cn/MyBatis/x-plugins/
     -->

</mapper>
', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:38:11', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (12, 1, 'serviceImpl', 'service实现类', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/service/${table.businessName}/${table.className}ServiceImpl.java', 'codegen/java/service/serviceImpl.vm', 'package ${basePackage}.module.${table.moduleName}.service.${table.businessName};

import org.springframework.stereotype.Service;
import ${jakartaPackage}.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
#end
import ${PageResultClassName};
import ${PageParamClassName};
import ${BeanUtils};

import ${basePackage}.module.${table.moduleName}.dal.mysql.${table.businessName}.${table.className}Mapper;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
import ${basePackage}.module.${subTable.moduleName}.dal.mysql.${subTable.businessName}.${subTable.className}Mapper;
#end

import static ${ServiceExceptionUtilClassName}.exception;
import static ${basePackage}.module.${table.moduleName}.enums.ErrorCodeConstants.*;

/**
 * ${table.classComment} Service 实现类
 *
 * @author ${table.author}
 */
@Service
@Validated
public class ${table.className}ServiceImpl implements ${table.className}Service {

    @Resource
    private ${table.className}Mapper ${classNameVar}Mapper;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
    @Resource
    private ${subTable.className}Mapper ${subClassNameVars.get($index)}Mapper;
#end

    @Override
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11 )
    @Transactional(rollbackFor = Exception.class)
#end
    public ${primaryColumn.javaType} create${simpleClassName}(${sceneEnum.prefixClass}${table.className}SaveReqVO createReqVO) {
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($TreeParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
#set ($TreeNameJavaField = $treeNameColumn.javaField.substring(0,1).toUpperCase() + ${treeNameColumn.javaField.substring(1)})##首字母大写
        // 校验${treeParentColumn.columnComment}的有效性
        validateParent${simpleClassName}(null, createReqVO.get${TreeParentJavaField}());
        // 校验${treeNameColumn.columnComment}的唯一性
        validate${simpleClassName}${TreeNameJavaField}Unique(null, createReqVO.get${TreeParentJavaField}(), createReqVO.get${TreeNameJavaField}());

#end
        // 插入
        ${table.className}DO ${classNameVar} = BeanUtils.toBean(createReqVO, ${table.className}DO.class);
        ${classNameVar}Mapper.insert(${classNameVar});
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11 )

        // 插入子表
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
    #if ( $subTable.subJoinMany)
        create${subSimpleClassName}List(${classNameVar}.getId(), createReqVO.get${subSimpleClassNames.get($index)}s());
    #else
        create${subSimpleClassName}(${classNameVar}.getId(), createReqVO.get${subSimpleClassNames.get($index)}());
    #end
#end
#end
        // 返回
        return ${classNameVar}.getId();
    }

    @Override
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11 )
    @Transactional(rollbackFor = Exception.class)
#end
    public void update${simpleClassName}(${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO) {
        // 校验存在
        validate${simpleClassName}Exists(updateReqVO.getId());
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($TreeParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
#set ($TreeNameJavaField = $treeNameColumn.javaField.substring(0,1).toUpperCase() + ${treeNameColumn.javaField.substring(1)})##首字母大写
        // 校验${treeParentColumn.columnComment}的有效性
        validateParent${simpleClassName}(updateReqVO.getId(), updateReqVO.get${TreeParentJavaField}());
        // 校验${treeNameColumn.columnComment}的唯一性
        validate${simpleClassName}${TreeNameJavaField}Unique(updateReqVO.getId(), updateReqVO.get${TreeParentJavaField}(), updateReqVO.get${TreeNameJavaField}());

#end
        // 更新
        ${table.className}DO updateObj = BeanUtils.toBean(updateReqVO, ${table.className}DO.class);
        ${classNameVar}Mapper.updateById(updateObj);
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11)

        // 更新子表
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
    #if ( $subTable.subJoinMany)
        update${subSimpleClassName}List(updateReqVO.getId(), updateReqVO.get${subSimpleClassNames.get($index)}s());
    #else
        update${subSimpleClassName}(updateReqVO.getId(), updateReqVO.get${subSimpleClassNames.get($index)}());
    #end
#end
#end
    }

    @Override
## 特殊：主子表专属逻辑
#if ( $subTables && $subTables.size() > 0)
    @Transactional(rollbackFor = Exception.class)
#end
    public void delete${simpleClassName}(${primaryColumn.javaType} id) {
        // 校验存在
        validate${simpleClassName}Exists(id);
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($ParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
        // 校验是否有子${table.classComment}
        if (${classNameVar}Mapper.selectCountBy${ParentJavaField}(id) > 0) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_EXITS_CHILDREN);
        }
#end
        // 删除
        ${classNameVar}Mapper.deleteById(id);
## 特殊：主子表专属逻辑
#if ( $subTables && $subTables.size() > 0)

        // 删除子表
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
        delete${subSimpleClassName}By${SubJoinColumnName}(id);
#end
#end
    }

    private void validate${simpleClassName}Exists(${primaryColumn.javaType} id) {
        if (${classNameVar}Mapper.selectById(id) == null) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_NOT_EXISTS);
        }
    }

## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($TreeParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
#set ($TreeNameJavaField = $treeNameColumn.javaField.substring(0,1).toUpperCase() + ${treeNameColumn.javaField.substring(1)})##首字母大写
    private void validateParent${simpleClassName}(Long id, Long ${treeParentColumn.javaField}) {
        if (${treeParentColumn.javaField} == null || ${simpleClassName}DO.${treeParentColumn_javaField_underlineCase.toUpperCase()}_ROOT.equals(${treeParentColumn.javaField})) {
            return;
        }
        // 1. 不能设置自己为父${table.classComment}
        if (Objects.equals(id, ${treeParentColumn.javaField})) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_PARENT_ERROR);
        }
        // 2. 父${table.classComment}不存在
        ${simpleClassName}DO parent${simpleClassName} = ${classNameVar}Mapper.selectById(${treeParentColumn.javaField});
        if (parent${simpleClassName} == null) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_PARENT_NOT_EXITS);
        }
        // 3. 递归校验父${table.classComment}，如果父${table.classComment}是自己的子${table.classComment}，则报错，避免形成环路
        if (id == null) { // id 为空，说明新增，不需要考虑环路
            return;
        }
        for (int i = 0; i < Short.MAX_VALUE; i++) {
            // 3.1 校验环路
            ${treeParentColumn.javaField} = parent${simpleClassName}.get${TreeParentJavaField}();
            if (Objects.equals(id, ${treeParentColumn.javaField})) {
                throw exception(${simpleClassName_underlineCase.toUpperCase()}_PARENT_IS_CHILD);
            }
            // 3.2 继续递归下一级父${table.classComment}
            if (${treeParentColumn.javaField} == null || ${simpleClassName}DO.${treeParentColumn_javaField_underlineCase.toUpperCase()}_ROOT.equals(${treeParentColumn.javaField})) {
                break;
            }
            parent${simpleClassName} = ${classNameVar}Mapper.selectById(${treeParentColumn.javaField});
            if (parent${simpleClassName} == null) {
                break;
            }
        }
    }

    private void validate${simpleClassName}${TreeNameJavaField}Unique(Long id, Long ${treeParentColumn.javaField}, String ${treeNameColumn.javaField}) {
        ${simpleClassName}DO ${classNameVar} = ${classNameVar}Mapper.selectBy${TreeParentJavaField}And${TreeNameJavaField}(${treeParentColumn.javaField}, ${treeNameColumn.javaField});
        if (${classNameVar} == null) {
            return;
        }
        // 如果 id 为空，说明不用比较是否为相同 id 的${table.classComment}
        if (id == null) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_${treeNameColumn_javaField_underlineCase.toUpperCase()}_DUPLICATE);
        }
        if (!Objects.equals(${classNameVar}.getId(), id)) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_${treeNameColumn_javaField_underlineCase.toUpperCase()}_DUPLICATE);
        }
    }

#end
    @Override
    public ${table.className}DO get${simpleClassName}(${primaryColumn.javaType} id) {
        return ${classNameVar}Mapper.selectById(id);
    }

## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
    @Override
    public PageResult<${table.className}DO> get${simpleClassName}Page(${sceneEnum.prefixClass}${table.className}PageReqVO pageReqVO) {
        return ${classNameVar}Mapper.selectPage(pageReqVO);
    }
#else
    @Override
    public List<${table.className}DO> get${simpleClassName}List(${sceneEnum.prefixClass}${table.className}ListReqVO listReqVO) {
        return ${classNameVar}Mapper.selectList(listReqVO);
    }
#end

## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($simpleClassNameUnderlineCase = $simpleClassNameUnderlineCases.get($index))
#set ($subPrimaryColumn = $subPrimaryColumns.get($index))##当前 primary 字段
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
#set ($subClassNameVar = $subClassNameVars.get($index))
    // ==================== 子表（$subTable.classComment） ====================

## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )
    @Override
    public PageResult<${subTable.className}DO> get${subSimpleClassName}Page(PageParam pageReqVO, ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return ${subClassNameVars.get($index)}Mapper.selectPage(pageReqVO, ${subJoinColumn.javaField});
    }

## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
    #if ( $subTable.subJoinMany )
    @Override
    public List<${subTable.className}DO> get${subSimpleClassName}ListBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return ${subClassNameVars.get($index)}Mapper.selectListBy${SubJoinColumnName}(${subJoinColumn.javaField});
    }

    #else
    @Override
    public ${subTable.className}DO get${subSimpleClassName}By${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return ${subClassNameVars.get($index)}Mapper.selectBy${SubJoinColumnName}(${subJoinColumn.javaField});
    }

    #end
#end
## 情况一：MASTER_ERP 时，支持单个的新增、修改、删除操作
#if ( $table.templateType == 11 )
    @Override
    public ${subPrimaryColumn.javaType} create${subSimpleClassName}(${subTable.className}DO ${subClassNameVar}) {
## 特殊：一对一时，需要保证只有一条，不能重复插入
#if ( !$subTable.subJoinMany)
        // 校验是否已经存在
        if (${subClassNameVars.get($index)}Mapper.selectBy${SubJoinColumnName}(${subClassNameVar}.get${SubJoinColumnName}()) != null) {
            throw exception(${simpleClassNameUnderlineCase.toUpperCase()}_EXISTS);
        }
        // 插入
#end
        ${subClassNameVars.get($index)}Mapper.insert(${subClassNameVar});
        return ${subClassNameVar}.getId();
    }

    @Override
    public void update${subSimpleClassName}(${subTable.className}DO ${subClassNameVar}) {
        // 校验存在
        validate${subSimpleClassName}Exists(${subClassNameVar}.getId());
        // 更新
        ${subClassNameVar}.setUpdater(null).setUpdateTime(null); // 解决更新情况下：updateTime 不更新
        ${subClassNameVars.get($index)}Mapper.updateById(${subClassNameVar});
    }

    @Override
    public void delete${subSimpleClassName}(${subPrimaryColumn.javaType} id) {
        // 校验存在
        validate${subSimpleClassName}Exists(id);
        // 删除
        ${subClassNameVars.get($index)}Mapper.deleteById(id);
    }

    @Override
    public ${subTable.className}DO get${subSimpleClassName}(${subPrimaryColumn.javaType} id) {
        return ${subClassNameVars.get($index)}Mapper.selectById(id);
    }

    private void validate${subSimpleClassName}Exists(${subPrimaryColumn.javaType} id) {
        if (${subClassNameVar}Mapper.selectById(id) == null) {
            throw exception(${simpleClassNameUnderlineCase.toUpperCase()}_NOT_EXISTS);
        }
    }

## 情况二：非 MASTER_ERP 时，支持批量的新增、修改操作
#else
    #if ( $subTable.subJoinMany)
    private void create${subSimpleClassName}List(${primaryColumn.javaType} ${subJoinColumn.javaField}, List<${subTable.className}DO> list) {
        list.forEach(o -> o.set$SubJoinColumnName(${subJoinColumn.javaField}));
        ${subClassNameVars.get($index)}Mapper.insertBatch(list);
    }

    private void update${subSimpleClassName}List(${primaryColumn.javaType} ${subJoinColumn.javaField}, List<${subTable.className}DO> list) {
        delete${subSimpleClassName}By${SubJoinColumnName}(${subJoinColumn.javaField});
		list.forEach(o -> o.setId(null).setUpdater(null).setUpdateTime(null)); // 解决更新情况下：1）id 冲突；2）updateTime 不更新
        create${subSimpleClassName}List(${subJoinColumn.javaField}, list);
    }

    #else
    private void create${subSimpleClassName}(${primaryColumn.javaType} ${subJoinColumn.javaField}, ${subTable.className}DO ${subClassNameVar}) {
        if (${subClassNameVar} == null) {
            return;
        }
        ${subClassNameVar}.set$SubJoinColumnName(${subJoinColumn.javaField});
        ${subClassNameVars.get($index)}Mapper.insert(${subClassNameVar});
    }

    private void update${subSimpleClassName}(${primaryColumn.javaType} ${subJoinColumn.javaField}, ${subTable.className}DO ${subClassNameVar}) {
        if (${subClassNameVar} == null) {
			return;
        }
        ${subClassNameVar}.set$SubJoinColumnName(${subJoinColumn.javaField});
        ${subClassNameVar}.setUpdater(null).setUpdateTime(null); // 解决更新情况下：updateTime 不更新
        ${subClassNameVars.get($index)}Mapper.insertOrUpdate(${subClassNameVar});
    }

    #end
#end
    private void delete${subSimpleClassName}By${SubJoinColumnName}(${primaryColumn.javaType} ${subJoinColumn.javaField}) {
        ${subClassNameVars.get($index)}Mapper.deleteBy${SubJoinColumnName}(${subJoinColumn.javaField});
    }

#end
}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:36', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (13, 1, 'service', 'service接口类', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/service/${table.businessName}/${table.className}Service.java', 'codegen/java/service/service.vm', 'package ${basePackage}.module.${table.moduleName}.service.${table.businessName};

import java.util.*;
import ${jakartaPackage}.validation.*;
import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
#end
import ${PageResultClassName};
import ${PageParamClassName};

/**
 * ${table.classComment} Service 接口
 *
 * @author ${table.author}
 */
public interface ${table.className}Service {

    /**
     * 创建${table.classComment}
     *
     * @param createReqVO 创建信息
     * @return 编号
     */
    ${primaryColumn.javaType} create${simpleClassName}(@Valid ${sceneEnum.prefixClass}${table.className}SaveReqVO createReqVO);

    /**
     * 更新${table.classComment}
     *
     * @param updateReqVO 更新信息
     */
    void update${simpleClassName}(@Valid ${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO);

    /**
     * 删除${table.classComment}
     *
     * @param id 编号
     */
    void delete${simpleClassName}(${primaryColumn.javaType} id);

    /**
     * 获得${table.classComment}
     *
     * @param id 编号
     * @return ${table.classComment}
     */
    ${table.className}DO get${simpleClassName}(${primaryColumn.javaType} id);

## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
    /**
     * 获得${table.classComment}分页
     *
     * @param pageReqVO 分页查询
     * @return ${table.classComment}分页
     */
    PageResult<${table.className}DO> get${simpleClassName}Page(${sceneEnum.prefixClass}${table.className}PageReqVO pageReqVO);
#else
    /**
     * 获得${table.classComment}列表
     *
     * @param listReqVO 查询条件
     * @return ${table.classComment}列表
     */
    List<${table.className}DO> get${simpleClassName}List(${sceneEnum.prefixClass}${table.className}ListReqVO listReqVO);
#end

## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subPrimaryColumn = $subPrimaryColumns.get($index))##当前 primary 字段
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
#set ($subClassNameVar = $subClassNameVars.get($index))
    // ==================== 子表（$subTable.classComment） ====================

## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )
    /**
     * 获得${subTable.classComment}分页
     *
     * @param pageReqVO 分页查询
     * @param ${subJoinColumn.javaField} ${subJoinColumn.columnComment}
     * @return ${subTable.classComment}分页
     */
    PageResult<${subTable.className}DO> get${subSimpleClassName}Page(PageParam pageReqVO, ${subJoinColumn.javaType} ${subJoinColumn.javaField});

## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
    #if ( $subTable.subJoinMany )
    /**
     * 获得${subTable.classComment}列表
     *
     * @param ${subJoinColumn.javaField} ${subJoinColumn.columnComment}
     * @return ${subTable.classComment}列表
     */
    List<${subTable.className}DO> get${subSimpleClassName}ListBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField});

    #else
    /**
     * 获得${subTable.classComment}
     *
     * @param ${subJoinColumn.javaField} ${subJoinColumn.columnComment}
     * @return ${subTable.classComment}
     */
    ${subTable.className}DO get${subSimpleClassName}By${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField});

    #end
#end
## 特殊：MASTER_ERP 时，支持单个的新增、修改、删除操作
#if ( $table.templateType == 11 )
    /**
     * 创建${subTable.classComment}
     *
     * @param ${subClassNameVar} 创建信息
     * @return 编号
     */
    ${subPrimaryColumn.javaType} create${subSimpleClassName}(@Valid ${subTable.className}DO ${subClassNameVar});

    /**
     * 更新${subTable.classComment}
     *
     * @param ${subClassNameVar} 更新信息
     */
    void update${subSimpleClassName}(@Valid ${subTable.className}DO ${subClassNameVar});

    /**
     * 删除${subTable.classComment}
     *
     * @param id 编号
     */
    void delete${subSimpleClassName}(${subPrimaryColumn.javaType} id);

	/**
	 * 获得${subTable.classComment}
	 *
	 * @param id 编号
     * @return ${subTable.classComment}
	 */
    ${subTable.className}DO get${subSimpleClassName}(${subPrimaryColumn.javaType} id);

#end
#end
}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:38', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (14, 1, 'serviceTest', 'service单测', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/test/java/${basePackageFilePath}/module/${table.moduleName}/service/${table.businessName}/${table.className}ServiceImplTest.java', 'codegen/java/test/serviceTest.vm', 'package ${basePackage}.module.${table.moduleName}.service.${table.businessName};

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.mock.mockito.MockBean;

import ${jakartaPackage}.annotation.Resource;

import ${baseFrameworkPackage}.test.core.ut.BaseDbUnitTest;

import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
import ${basePackage}.module.${table.moduleName}.dal.mysql.${table.businessName}.${table.className}Mapper;
import ${PageResultClassName};

import ${jakartaPackage}.annotation.Resource;
import org.springframework.context.annotation.Import;
import java.util.*;
import java.time.LocalDateTime;

import static cn.hutool.core.util.RandomUtil.*;
import static ${basePackage}.module.${table.moduleName}.enums.ErrorCodeConstants.*;
import static ${baseFrameworkPackage}.test.core.util.AssertUtils.*;
import static ${baseFrameworkPackage}.test.core.util.RandomUtils.*;
import static ${LocalDateTimeUtilsClassName}.*;
import static ${ObjectUtilsClassName}.*;
import static ${DateUtilsClassName}.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

## 字段模板
#macro(getPageCondition $VO)
       // mock 数据
       ${table.className}DO db${simpleClassName} = randomPojo(${table.className}DO.class, o -> { // 等会查询到
       #foreach ($column in $columns)
       #if (${column.listOperation})
       #set ($JavaField = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})##首字母大写
           o.set$JavaField(null);
       #end
       #end
       });
       ${classNameVar}Mapper.insert(db${simpleClassName});
       #foreach ($column in $columns)
       #if (${column.listOperation})
       #set ($JavaField = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})##首字母大写
       // 测试 ${column.javaField} 不匹配
       ${classNameVar}Mapper.insert(cloneIgnoreId(db${simpleClassName}, o -> o.set$JavaField(null)));
       #end
       #end
       // 准备参数
       ${sceneEnum.prefixClass}${table.className}${VO} reqVO = new ${sceneEnum.prefixClass}${table.className}${VO}();
       #foreach ($column in $columns)
       #if (${column.listOperation})
       #set ($JavaField = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})##首字母大写
       #if (${column.listOperationCondition} == "BETWEEN")## BETWEEN 的情况
       reqVO.set${JavaField}(buildBetweenTime(2023, 2, 1, 2023, 2, 28));
       #else
       reqVO.set$JavaField(null);
       #end
       #end
       #end
#end
/**
 * {@link ${table.className}ServiceImpl} 的单元测试类
 *
 * @author ${table.author}
 */
@Import(${table.className}ServiceImpl.class)
public class ${table.className}ServiceImplTest extends BaseDbUnitTest {

    @Resource
    private ${table.className}ServiceImpl ${classNameVar}Service;

    @Resource
    private ${table.className}Mapper ${classNameVar}Mapper;

    @Test
    public void testCreate${simpleClassName}_success() {
        // 准备参数
        ${sceneEnum.prefixClass}${table.className}SaveReqVO createReqVO = randomPojo(${sceneEnum.prefixClass}${table.className}SaveReqVO.class).setId(null);

        // 调用
        ${primaryColumn.javaType} ${classNameVar}Id = ${classNameVar}Service.create${simpleClassName}(createReqVO);
        // 断言
        assertNotNull(${classNameVar}Id);
        // 校验记录的属性是否正确
        ${table.className}DO ${classNameVar} = ${classNameVar}Mapper.selectById(${classNameVar}Id);
        assertPojoEquals(createReqVO, ${classNameVar}, "id");
    }

    @Test
    public void testUpdate${simpleClassName}_success() {
        // mock 数据
        ${table.className}DO db${simpleClassName} = randomPojo(${table.className}DO.class);
        ${classNameVar}Mapper.insert(db${simpleClassName});// @Sql: 先插入出一条存在的数据
        // 准备参数
        ${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO = randomPojo(${sceneEnum.prefixClass}${table.className}SaveReqVO.class, o -> {
            o.setId(db${simpleClassName}.getId()); // 设置更新的 ID
        });

        // 调用
        ${classNameVar}Service.update${simpleClassName}(updateReqVO);
        // 校验是否更新正确
        ${table.className}DO ${classNameVar} = ${classNameVar}Mapper.selectById(updateReqVO.getId()); // 获取最新的
        assertPojoEquals(updateReqVO, ${classNameVar});
    }

    @Test
    public void testUpdate${simpleClassName}_notExists() {
        // 准备参数
        ${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO = randomPojo(${sceneEnum.prefixClass}${table.className}SaveReqVO.class);

        // 调用, 并断言异常
        assertServiceException(() -> ${classNameVar}Service.update${simpleClassName}(updateReqVO), ${simpleClassName_underlineCase.toUpperCase()}_NOT_EXISTS);
    }

    @Test
    public void testDelete${simpleClassName}_success() {
        // mock 数据
        ${table.className}DO db${simpleClassName} = randomPojo(${table.className}DO.class);
        ${classNameVar}Mapper.insert(db${simpleClassName});// @Sql: 先插入出一条存在的数据
        // 准备参数
        ${primaryColumn.javaType} id = db${simpleClassName}.getId();

        // 调用
        ${classNameVar}Service.delete${simpleClassName}(id);
       // 校验数据不存在了
       assertNull(${classNameVar}Mapper.selectById(id));
    }

    @Test
    public void testDelete${simpleClassName}_notExists() {
        // 准备参数
        ${primaryColumn.javaType} id = random${primaryColumn.javaType}Id();

        // 调用, 并断言异常
        assertServiceException(() -> ${classNameVar}Service.delete${simpleClassName}(id), ${simpleClassName_underlineCase.toUpperCase()}_NOT_EXISTS);
    }

## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
    @Test
    @Disabled  // TODO 请修改 null 为需要的值，然后删除 @Disabled 注解
    public void testGet${simpleClassName}Page() {
       #getPageCondition("PageReqVO")

       // 调用
       PageResult<${table.className}DO> pageResult = ${classNameVar}Service.get${simpleClassName}Page(reqVO);
       // 断言
       assertEquals(1, pageResult.getTotal());
       assertEquals(1, pageResult.getList().size());
       assertPojoEquals(db${simpleClassName}, pageResult.getList().get(0));
    }
#else
    @Test
    @Disabled  // TODO 请修改 null 为需要的值，然后删除 @Disabled 注解
    public void testGet${simpleClassName}List() {
       #getPageCondition("ListReqVO")

       // 调用
       List<${table.className}DO> list = ${classNameVar}Service.get${simpleClassName}List(reqVO);
       // 断言
       assertEquals(1, list.size());
       assertPojoEquals(db${simpleClassName}, list.get(0));
    }
#end

}
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:39', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (15, 1, 'errorcode', '异常code', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-api/src/main/java/${basePackageFilePath}/module/${table.moduleName}/enums/ErrorCodeConstants_手动操作.java', 'codegen/java/enums/errorcode.vm', '// TODO 待办：请将下面的错误码复制到 yudao-module-${table.moduleName}-api 模块的 ErrorCodeConstants 类中。注意，请给“TODO 补充编号”设置一个错误码编号！！！
// ========== ${table.classComment} TODO 补充编号 ==========
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_NOT_EXISTS = new ErrorCode(TODO 补充编号, "${table.classComment}不存在");
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_EXITS_CHILDREN = new ErrorCode(TODO 补充编号, "存在存在子${table.classComment}，无法删除");
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_PARENT_NOT_EXITS = new ErrorCode(TODO 补充编号,"父级${table.classComment}不存在");
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_PARENT_ERROR = new ErrorCode(TODO 补充编号, "不能设置自己为父${table.classComment}");
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_${treeNameColumn_javaField_underlineCase.toUpperCase()}_DUPLICATE = new ErrorCode(TODO 补充编号, "已经存在该${treeNameColumn.columnComment}的${table.classComment}");
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_PARENT_IS_CHILD = new ErrorCode(TODO 补充编号, "不能设置自己的子${table.className}为父${table.className}");
#end
## 特殊：主子表专属逻辑
#if ( $table.templateType == 11 )## 特殊：ERP 情况
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($simpleClassNameUnderlineCase = $simpleClassNameUnderlineCases.get($index))
ErrorCode ${simpleClassNameUnderlineCase.toUpperCase()}_NOT_EXISTS = new ErrorCode(TODO 补充编号, "${subTable.classComment}不存在");
#if ( !$subTable.subJoinMany )
ErrorCode ${simpleClassNameUnderlineCase.toUpperCase()}_EXISTS = new ErrorCode(TODO 补充编号, "${subTable.classComment}已存在");
#end
#end
#end
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 15:01:42', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (16, 1, 'menu_sql', '菜单的执行sql', 'SERVER', 'SERVER', 'java', 'sql/sql.sql', 'codegen/sql/sql.vm', '-- 菜单 SQL
INSERT INTO system_menu(
    name, permission, type, sort, parent_id,
    path, icon, component, status, component_name
)
VALUES (
    \'${table.classComment}管理\', \'\', 2, 0, ${table.parentMenuId},
    \'${simpleClassName_strikeCase}\', \'\', \'${table.moduleName}/${table.businessName}/index\', 0, \'${table.className}\'
);

-- 按钮父菜单ID
-- 暂时只支持 MySQL。如果你是 Oracle、PostgreSQL、SQLServer 的话，需要手动修改 @parentId 的部分的代码
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
#set ($functionNames = [\'查询\', \'创建\', \'更新\', \'删除\', \'导出\'])
#set ($functionOps = [\'query\', \'create\', \'update\', \'delete\', \'export\'])
#foreach ($functionName in $functionNames)
#set ($index = $foreach.count - 1)
INSERT INTO system_menu(
    name, permission, type, sort, parent_id,
    path, icon, component, status
)
VALUES (
    \'${table.classComment}${functionName}\', \'${permissionPrefix}:${functionOps.get($index)}\', 3, $foreach.count, @parentId,
    \'\', \'\', \'\', 0
);
#end
', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:40:31', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (17, 1, 'h2_sql', 'h2类型数据库sql', 'SERVER', 'SERVER', 'java', 'sql/h2.sql', 'codegen/sql/h2.vm', '-- 将该建表 SQL 语句，添加到 yudao-module-${table.moduleName}-biz 模块的 test/resources/sql/create_tables.sql 文件里
CREATE TABLE IF NOT EXISTS "${table.tableName.toLowerCase()}" (
#foreach ($column in $columns)
#if (${column.javaType} == \'Long\')
    #set ($dataType=\'bigint\')
#elseif (${column.javaType} == \'Integer\')
    #set ($dataType=\'int\')
#elseif (${column.javaType} == \'Boolean\')
    #set ($dataType=\'bit\')
#elseif (${column.javaType} == \'Date\')
    #set ($dataType=\'datetime\')
#else
    #set ($dataType=\'varchar\')
#end
    #if (${column.primaryKey})##处理主键
    "${column.javaField}"#if (${column.javaType} == \'String\') ${dataType} NOT NULL#else ${dataType} NOT NULL GENERATED BY DEFAULT AS IDENTITY#end,
    #else
    #if (${column.columnName} == \'create_time\')
    "create_time" datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    #elseif (${column.columnName} == \'update_time\')
    "update_time" datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    #elseif (${column.columnName} == \'creator\' || ${column.columnName} == \'updater\')
    "${column.columnName}" ${dataType} DEFAULT \'\',
    #elseif (${column.columnName} == \'deleted\')
    "deleted" bit NOT NULL DEFAULT FALSE,
    #elseif (${column.columnName} == \'tenant_id\')
    "tenant_id" bigint NOT NULL DEFAULT 0,
    #else
    "${column.columnName.toLowerCase()}" ${dataType}#if (${column.nullable} == false) NOT NULL#end,
    #end
    #end
#end
    PRIMARY KEY ("${primaryColumn.columnName.toLowerCase()}")
) COMMENT \'${table.tableComment}\';

-- 将该删表 SQL 语句，添加到 yudao-module-${table.moduleName}-biz 模块的 test/resources/sql/clean.sql 文件里
DELETE FROM "${table.tableName}";
', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:41:08', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (18, 1, 'vue2_index.vue.vm', 'vue2_index.vue.vm', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/index.vue', 'codegen/vue/views/index.vue.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:47:38', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (19, 1, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/api/${table.moduleName}/${table.businessName}/index.js', 'codegen/vue/api/api.js.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:47:27', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (20, 1, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/${simpleClassName}Form.vue', 'codegen/vue/views/form.vue.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:47:27', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (21, 1, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue/views/components/form_sub_normal.vue.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:17', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (22, 1, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue/views/components/form_sub_inner.vue.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:19', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (23, 1, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue/views/components/form_sub_erp.vue.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:22', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (24, 1, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}List.vue', 'codegen/vue/views/components/list_sub_inner.vue.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:24', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (25, 1, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}List.vue', 'codegen/vue/views/components/list_sub_erp.vue.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:26', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (26, 1, 'vue3_index', 'vue3前端index', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/index.vue', 'codegen/vue3/views/index.vue.vm', '<template>
  <ContentWrap>
    <!-- 搜索工作栏 -->
    <el-form
      class="-mb-15px"
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
    #foreach($column in $columns)
        #if ($column.listOperation)
            #set ($dictType = $column.dictType)
            #set ($javaField = $column.javaField)
            #set ($javaType = $column.javaType)
            #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
            #set ($comment = $column.columnComment)
            #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
            #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
                #set ($dictMethod = "getIntDictOptions")
            #elseif ($javaType == "String")
                #set ($dictMethod = "getStrDictOptions")
            #elseif ($javaType == "Boolean")
                #set ($dictMethod = "getBoolDictOptions")
            #end
            #if ($column.htmlType == "input")
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input
          v-model="queryParams.${javaField}"
          placeholder="请输入${comment}"
          clearable
          @keyup.enter="handleQuery"
          class="!w-240px"
        />
      </el-form-item>
            #elseif ($column.htmlType == "select" || $column.htmlType == "radio")
      <el-form-item label="${comment}" prop="${javaField}">
        <el-select
          v-model="queryParams.${javaField}"
          placeholder="请选择${comment}"
          clearable
          class="!w-240px"
        >
                #if ("" != $dictType)## 设置了 dictType 数据字典的情况
          <el-option
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else## 未设置 dictType 数据字典的情况
          <el-option label="请选择字典生成" value="" />
                #end
        </el-select>
      </el-form-item>
    #elseif($column.htmlType == "datetime")
      #if ($column.listOperationCondition != "BETWEEN")## 非范围
      <el-form-item label="${comment}" prop="${javaField}">
        <el-date-picker
          v-model="queryParams.${javaField}"
          value-format="YYYY-MM-DD"
          type="date"
          placeholder="选择${comment}"
          clearable
          class="!w-240px"
        />
      </el-form-item>
      #else## 范围
      <el-form-item label="${comment}" prop="${javaField}">
        <el-date-picker
          v-model="queryParams.${javaField}"
          value-format="YYYY-MM-DD HH:mm:ss"
          type="daterange"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          :default-time="[new Date(\'1 00:00:00\'), new Date(\'1 23:59:59\')]"
          class="!w-220px"
        />
      </el-form-item>
      #end
    #end
    #end
    #end
      <el-form-item>
        <el-button @click="handleQuery"><Icon icon="ep:search" class="mr-5px" /> 搜索</el-button>
        <el-button @click="resetQuery"><Icon icon="ep:refresh" class="mr-5px" /> 重置</el-button>
        <el-button
          type="primary"
          plain
          @click="openForm(\'create\')"
          v-hasPermi="[\'${permissionPrefix}:create\']"
        >
          <Icon icon="ep:plus" class="mr-5px" /> 新增
        </el-button>
        <el-button
          type="success"
          plain
          @click="handleExport"
          :loading="exportLoading"
          v-hasPermi="[\'${permissionPrefix}:export\']"
        >
          <Icon icon="ep:download" class="mr-5px" /> 导出
        </el-button>
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
        <el-button type="danger" plain @click="toggleExpandAll">
          <Icon icon="ep:sort" class="mr-5px" /> 展开/折叠
        </el-button>
#end
      </el-form-item>
    </el-form>
  </ContentWrap>

  <!-- 列表 -->
  <ContentWrap>
## 特殊：主子表专属逻辑
#if ( $table.templateType == 11 && $subTables && $subTables.size() > 0 )
    <el-table
      v-loading="loading"
      :data="list"
      :stripe="true"
      :show-overflow-tooltip="true"
      highlight-current-row
      @current-change="handleCurrentChange"
    >
## 特殊：树表专属逻辑
#elseif ( $table.templateType == 2 )
    <el-table
      v-loading="loading"
      :data="list"
      :stripe="true"
      :show-overflow-tooltip="true"
      row-key="id"
      :default-expand-all="isExpandAll"
      v-if="refreshTable"
    >
#else
    <el-table v-loading="loading" :data="list" :stripe="true" :show-overflow-tooltip="true">
#end
## 特殊：主子表专属逻辑
#if ( $table.templateType == 12 && $subTables && $subTables.size() > 0 )
      <!-- 子表的列表 -->
      <el-table-column type="expand">
        <template #default="scope">
          <el-tabs model-value="$subClassNameVars.get(0)">
            #foreach ($subTable in $subTables)
              #set ($index = $foreach.count - 1)
              #set ($subClassNameVar = $subClassNameVars.get($index))
              #set ($subSimpleClassName = $subSimpleClassNames.get($index))
              #set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
            <el-tab-pane label="${subTable.classComment}" name="$subClassNameVar">
              <${subSimpleClassName}List :${subJoinColumn_strikeCase}="scope.row.id" />
            </el-tab-pane>
            #end
          </el-tabs>
        </template>
      </el-table-column>
#end
      #foreach($column in $columns)
      #if ($column.listOperationResult)
        #set ($dictType=$column.dictType)
        #set ($javaField = $column.javaField)
        #set ($AttrName=$column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment=$column.columnComment)
        #if ($column.javaType == "LocalDateTime")## 时间类型
      <el-table-column
        label="${comment}"
        align="center"
        prop="${javaField}"
        :formatter="dateFormatter"
        width="180px"
      />
        #elseif($column.dictType && "" != $column.dictType)## 数据字典
      <el-table-column label="${comment}" align="center" prop="${javaField}">
        <template #default="scope">
          <dict-tag :type="DICT_TYPE.$dictType.toUpperCase()" :value="scope.row.${column.javaField}" />
        </template>
      </el-table-column>
        #else
      <el-table-column label="${comment}" align="center" prop="${javaField}" />
        #end
      #end
    #end
      <el-table-column label="操作" align="center" min-width="120px">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="openForm(\'update\', scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:update\']"
          >
            编辑
          </el-button>
          <el-button
            link
            type="danger"
            @click="handleDelete(scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:delete\']"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </ContentWrap>

  <!-- 表单弹窗：添加/修改 -->
  <${simpleClassName}Form ref="formRef" @success="getList" />
## 特殊：主子表专属逻辑
#if ( $table.templateType == 11 && $subTables && $subTables.size() > 0 )
  <!-- 子表的列表 -->
  <ContentWrap>
    <el-tabs model-value="$subClassNameVars.get(0)">
      #foreach ($subTable in $subTables)
        #set ($index = $foreach.count - 1)
        #set ($subClassNameVar = $subClassNameVars.get($index))
        #set ($subSimpleClassName = $subSimpleClassNames.get($index))
        #set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
      <el-tab-pane label="${subTable.classComment}" name="$subClassNameVar">
        <${subSimpleClassName}List :${subJoinColumn_strikeCase}="currentRow.id" />
      </el-tab-pane>
      #end
    </el-tabs>
  </ContentWrap>
#end
</template>

<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { dateFormatter } from \'@/utils/formatTime\'
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
import { handleTree } from \'@/utils/tree\'
#end
import download from \'@/utils/download\'
import { ${simpleClassName}Api, ${simpleClassName}VO } from \'@/api/${table.moduleName}/${table.businessName}\'
import ${simpleClassName}Form from \'./${simpleClassName}Form.vue\'
## 特殊：主子表专属逻辑
#if ( $table.templateType != 10 )
#foreach ($subSimpleClassName in $subSimpleClassNames)
import ${subSimpleClassName}List from \'./components/${subSimpleClassName}List.vue\'
#end
#end

/** ${table.classComment} 列表 */
defineOptions({ name: \'${table.className}\' })

const message = useMessage() // 消息弹窗
const { t } = useI18n() // 国际化

const loading = ref(true) // 列表的加载中
const list = ref<${simpleClassName}VO[]>([]) // 列表的数据
## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
const total = ref(0) // 列表的总页数
#end
const queryParams = reactive({
## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
  pageNo: 1,
  pageSize: 10,
#end
  #foreach ($column in $columns)
    #if ($column.listOperation)
      #if ($column.listOperationCondition != \'BETWEEN\')
  $column.javaField: undefined,
  #end
      #if ($column.htmlType == "datetime" || $column.listOperationCondition == "BETWEEN")
  $column.javaField: [],
      #end
    #end
  #end
})
const queryFormRef = ref() // 搜索的表单
const exportLoading = ref(false) // 导出的加载中

/** 查询列表 */
const getList = async () => {
  loading.value = true
  try {
## 特殊：树表专属逻辑（树不需要分页接口）
  #if ( $table.templateType == 2 )
    const data = await ${simpleClassName}Api.get${simpleClassName}List(queryParams)
    list.value = handleTree(data, \'id\', \'${treeParentColumn.javaField}\')
  #else
    const data = await ${simpleClassName}Api.get${simpleClassName}Page(queryParams)
    list.value = data.list
    total.value = data.total
  #end
  } finally {
    loading.value = false
  }
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.pageNo = 1
  getList()
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value.resetFields()
  handleQuery()
}

/** 添加/修改操作 */
const formRef = ref()
const openForm = (type: string, id?: number) => {
  formRef.value.open(type, id)
}

/** 删除按钮操作 */
const handleDelete = async (id: number) => {
  try {
    // 删除的二次确认
    await message.delConfirm()
    // 发起删除
    await ${simpleClassName}Api.delete${simpleClassName}(id)
    message.success(t(\'common.delSuccess\'))
    // 刷新列表
    await getList()
  } catch {}
}

/** 导出按钮操作 */
const handleExport = async () => {
  try {
    // 导出的二次确认
    await message.exportConfirm()
    // 发起导出
    exportLoading.value = true
    const data = await ${simpleClassName}Api.export${simpleClassName}(queryParams)
    download.excel(data, \'${table.classComment}.xls\')
  } catch {
  } finally {
    exportLoading.value = false
  }
}
## 特殊：主子表专属逻辑
#if ( $table.templateType == 11 )

/** 选中行操作 */
const currentRow = ref({}) // 选中行
const handleCurrentChange = (row) => {
  currentRow.value = row
}
#end
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )

/** 展开/折叠操作 */
const isExpandAll = ref(true) // 是否展开，默认全部展开
const refreshTable = ref(true) // 重新渲染表格状态
const toggleExpandAll = async () => {
  refreshTable.value = false
  isExpandAll.value = !isExpandAll.value
  await nextTick()
  refreshTable.value = true
}
#end

/** 初始化 **/
onMounted(() => {
  getList()
})
</script>
', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:42:36', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (27, 1, 'vue3_form', 'vue3的前端弹出表单，用于新增修改', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/${simpleClassName}Form.vue', 'codegen/vue3/views/form.vue.vm', '<template>
  <Dialog :title="dialogTitle" v-model="dialogVisible">
    <el-form
      ref="formRef"
      :model="formData"
      :rules="formRules"
      label-width="100px"
      v-loading="formLoading"
    >
#foreach($column in $columns)
    #if ($column.createOperation || $column.updateOperation)
        #set ($dictType = $column.dictType)
        #set ($javaField = $column.javaField)
        #set ($javaType = $column.javaType)
        #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment = $column.columnComment)
        #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
        #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
            #set ($dictMethod = "getIntDictOptions")
        #elseif ($javaType == "String")
            #set ($dictMethod = "getStrDictOptions")
        #elseif ($javaType == "Boolean")
            #set ($dictMethod = "getBoolDictOptions")
        #end
        #if ( $table.templateType == 2 && $column.id == $treeParentColumn.id )
      <el-form-item label="${comment}" prop="${javaField}">
        <el-tree-select
          v-model="formData.${javaField}"
          :data="${classNameVar}Tree"
          #if ($treeNameColumn.javaField == "name")
          :props="defaultProps"
          #else
          :props="{...defaultProps, label: \'$treeNameColumn.javaField\'}"
          #end
          check-strictly
          default-expand-all
          placeholder="请选择${comment}"
        />
      </el-form-item>
        #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input v-model="formData.${javaField}" placeholder="请输入${comment}" />
      </el-form-item>
        #elseif($column.htmlType == "imageUpload")## 图片上传
      <el-form-item label="${comment}" prop="${javaField}">
        <UploadImg v-model="formData.${javaField}" />
      </el-form-item>
        #elseif($column.htmlType == "fileUpload")## 文件上传
      <el-form-item label="${comment}" prop="${javaField}">
        <UploadFile v-model="formData.${javaField}" />
      </el-form-item>
        #elseif($column.htmlType == "editor")## 文本编辑器
      <el-form-item label="${comment}" prop="${javaField}">
        <Editor v-model="formData.${javaField}" height="150px" />
      </el-form-item>
        #elseif($column.htmlType == "select")## 下拉框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-select v-model="formData.${javaField}" placeholder="请选择${comment}">
                #if ("" != $dictType)## 有数据字典
          <el-option
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else##没数据字典
          <el-option label="请选择字典生成" value="" />
                #end
        </el-select>
      </el-form-item>
        #elseif($column.htmlType == "checkbox")## 多选框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-checkbox-group v-model="formData.${javaField}">
                #if ("" != $dictType)## 有数据字典
          <el-checkbox
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else##没数据字典
          <el-checkbox label="请选择字典生成" />
                #end
        </el-checkbox-group>
      </el-form-item>
        #elseif($column.htmlType == "radio")## 单选框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-radio-group v-model="formData.${javaField}">
                #if ("" != $dictType)## 有数据字典
          <el-radio
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.value"
          >
            {{ dict.label }}
          </el-radio>
                #else##没数据字典
          <el-radio value="1">请选择字典生成</el-radio>
                #end
        </el-radio-group>
      </el-form-item>
        #elseif($column.htmlType == "datetime")## 时间框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-date-picker
          v-model="formData.${javaField}"
          type="date"
          value-format="x"
          placeholder="选择${comment}"
        />
      </el-form-item>
        #elseif($column.htmlType == "textarea")## 文本框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input v-model="formData.${javaField}" type="textarea" placeholder="请输入${comment}" />
      </el-form-item>
        #end
    #end
#end
    </el-form>
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
    <!-- 子表的表单 -->
    <el-tabs v-model="subTabsName">
    #foreach ($subTable in $subTables)
      #set ($index = $foreach.count - 1)
      #set ($subClassNameVar = $subClassNameVars.get($index))
      #set ($subSimpleClassName = $subSimpleClassNames.get($index))
      #set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
      <el-tab-pane label="${subTable.classComment}" name="$subClassNameVar">
        <${subSimpleClassName}Form ref="${subClassNameVar}FormRef" :${subJoinColumn_strikeCase}="formData.id" />
      </el-tab-pane>
    #end
    </el-tabs>
#end
    <template #footer>
      <el-button @click="submitForm" type="primary" :disabled="formLoading">确 定</el-button>
      <el-button @click="dialogVisible = false">取 消</el-button>
    </template>
  </Dialog>
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { ${simpleClassName}Api, ${simpleClassName}VO } from \'@/api/${table.moduleName}/${table.businessName}\'
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
import { defaultProps, handleTree } from \'@/utils/tree\'
#end
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
#foreach ($subSimpleClassName in $subSimpleClassNames)
import ${subSimpleClassName}Form from \'./components/${subSimpleClassName}Form.vue\'
#end
#end

/** ${table.classComment} 表单 */
defineOptions({ name: \'${simpleClassName}Form\' })

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const dialogVisible = ref(false) // 弹窗的是否展示
const dialogTitle = ref(\'\') // 弹窗的标题
const formLoading = ref(false) // 表单的加载中：1）修改时的数据加载；2）提交的按钮禁用
const formType = ref(\'\') // 表单的类型：create - 新增；update - 修改
const formData = ref({
#foreach ($column in $columns)
    #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
  $column.javaField: [],
      #else
  $column.javaField: undefined,
      #end
    #end
#end
})
const formRules = reactive({
#foreach ($column in $columns)
    #if (($column.createOperation || $column.updateOperation) && !$column.nullable && !${column.primaryKey})## 创建或者更新操作 && 要求非空 && 非主键
        #set($comment=$column.columnComment)
  $column.javaField: [{ required: true, message: \'${comment}不能为空\', trigger: #if($column.htmlType == \'select\')\'change\'#else\'blur\'#end }],
    #end
#end
})
const formRef = ref() // 表单 Ref
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
const ${classNameVar}Tree = ref() // 树形结构
#end
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
#if ( $subTables && $subTables.size() > 0 )

/** 子表的表单 */
const subTabsName = ref(\'$subClassNameVars.get(0)\')
#foreach ($subClassNameVar in $subClassNameVars)
const ${subClassNameVar}FormRef = ref()
#end
#end
#end

/** 打开弹窗 */
const open = async (type: string, id?: number) => {
  dialogVisible.value = true
  dialogTitle.value = t(\'action.\' + type)
  formType.value = type
  resetForm()
  // 修改时，设置数据
  if (id) {
    formLoading.value = true
    try {
      formData.value = await ${simpleClassName}Api.get${simpleClassName}(id)
    } finally {
      formLoading.value = false
    }
  }
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
  await get${simpleClassName}Tree()
#end
}
defineExpose({ open }) // 提供 open 方法，用于打开弹窗

/** 提交表单 */
const emit = defineEmits([\'success\']) // 定义 success 事件，用于操作成功后的回调
const submitForm = async () => {
  // 校验表单
  await formRef.value.validate()
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
#if ( $subTables && $subTables.size() > 0 )
  // 校验子表单
  #foreach ($subTable in $subTables)
  #set ($index = $foreach.count - 1)
  #set ($subClassNameVar = $subClassNameVars.get($index))
  try {
    await ${subClassNameVar}FormRef.value.validate()
  } catch (e) {
    subTabsName.value = \'${subClassNameVar}\'
    return
  }
  #end
#end
#end
  // 提交请求
  formLoading.value = true
  try {
    const data = formData.value as unknown as ${simpleClassName}VO
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
#if ( $subTables && $subTables.size() > 0 )
    // 拼接子表的数据
  #foreach ($subTable in $subTables)
  #set ($index = $foreach.count - 1)
  #set ($subClassNameVar = $subClassNameVars.get($index))
    data.${subClassNameVar}#if ( $subTable.subJoinMany)s#end = ${subClassNameVar}FormRef.value.getData()
  #end
#end
#end
    if (formType.value === \'create\') {
      await ${simpleClassName}Api.create${simpleClassName}(data)
      message.success(t(\'common.createSuccess\'))
    } else {
      await ${simpleClassName}Api.update${simpleClassName}(data)
      message.success(t(\'common.updateSuccess\'))
    }
    dialogVisible.value = false
    // 发送操作成功的事件
    emit(\'success\')
  } finally {
    formLoading.value = false
  }
}

/** 重置表单 */
const resetForm = () => {
  formData.value = {
#foreach ($column in $columns)
  #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
    $column.javaField: [],
      #else
    $column.javaField: undefined,
      #end
  #end
#end
  }
  formRef.value?.resetFields()
}
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )

/** 获得${table.classComment}树 */
const get${simpleClassName}Tree = async () => {
  ${classNameVar}Tree.value = []
  const data = await ${simpleClassName}Api.get${simpleClassName}List()
  const root: Tree = { id: 0, name: \'顶级${table.classComment}\', children: [] }
  root.children = handleTree(data, \'id\', \'${treeParentColumn.javaField}\')
  ${classNameVar}Tree.value.push(root)
}
#end
</script>
', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:43:13', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (28, 1, 'vue3_ form_sub_normal.vue', 'vue3表单通用子表实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue3/views/components/form_sub_normal.vue.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
<template>
#if ( $subTable.subJoinMany )## 情况一：一对多，table + form
  <el-form
    ref="formRef"
    :model="formData"
    :rules="formRules"
    v-loading="formLoading"
    label-width="0px"
    :inline-message="true"
  >
    <el-table :data="formData" class="-mt-10px">
      <el-table-column label="序号" type="index" width="100" />
#foreach($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
        #set ($dictType = $column.dictType)
        #set ($javaField = $column.javaField)
        #set ($javaType = $column.javaType)
        #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment = $column.columnComment)
        #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
        #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
            #set ($dictMethod = "getIntDictOptions")
        #elseif ($javaType == "String")
            #set ($dictMethod = "getStrDictOptions")
        #elseif ($javaType == "Boolean")
            #set ($dictMethod = "getBoolDictOptions")
        #end
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-input v-model="row.${javaField}" placeholder="请输入${comment}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "imageUpload")## 图片上传
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <UploadImg v-model="row.${javaField}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "fileUpload")## 文件上传
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <UploadFile v-model="row.${javaField}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "editor")## 文本编辑器
      <el-table-column label="${comment}" min-width="400">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <Editor v-model="row.${javaField}" height="150px" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "select")## 下拉框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-select v-model="row.${javaField}" placeholder="请选择${comment}">
              #if ("" != $dictType)## 有数据字典
                <el-option
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              #else##没数据字典
                <el-option label="请选择字典生成" value="" />
              #end
            </el-select>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "checkbox")## 多选框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-checkbox-group v-model="row.${javaField}">
              #if ("" != $dictType)## 有数据字典
                <el-checkbox
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              #else##没数据字典
                <el-checkbox label="请选择字典生成" />
              #end
            </el-checkbox-group>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "radio")## 单选框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-radio-group v-model="row.${javaField}">
              #if ("" != $dictType)## 有数据字典
                <el-radio
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.value"
                >
                  {{ dict.label }}
                </el-radio>
              #else##没数据字典
                <el-radio value="1">请选择字典生成</el-radio>
              #end
            </el-radio-group>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "datetime")## 时间框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-date-picker
              v-model="row.${javaField}"
              type="date"
              value-format="x"
              placeholder="选择${comment}"
            />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "textarea")## 文本框
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-input v-model="row.${javaField}" type="textarea" placeholder="请输入${comment}" />
          </el-form-item>
        </template>
      </el-table-column>
        #end
    #end
#end
      <el-table-column align="center" fixed="right" label="操作" width="60">
        <template #default="{ $index }">
          <el-button @click="handleDelete($index)" link>—</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-form>
  <el-row justify="center" class="mt-3">
    <el-button @click="handleAdd" round>+ 添加${subTable.classComment}</el-button>
  </el-row>
#else## 情况二：一对一，form
  <el-form
    ref="formRef"
    :model="formData"
    :rules="formRules"
    label-width="100px"
    v-loading="formLoading"
  >
#foreach($column in $subColumns)
  #if ($column.createOperation || $column.updateOperation)
  #set ($dictType = $column.dictType)
      #set ($javaField = $column.javaField)
      #set ($javaType = $column.javaType)
      #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
      #set ($comment = $column.columnComment)
      #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
      #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
        #set ($dictMethod = "getIntDictOptions")
      #elseif ($javaType == "String")
          #set ($dictMethod = "getStrDictOptions")
      #elseif ($javaType == "Boolean")
          #set ($dictMethod = "getBoolDictOptions")
      #end
      #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
      #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
    <el-form-item label="${comment}" prop="${javaField}">
      <el-input v-model="formData.${javaField}" placeholder="请输入${comment}" />
    </el-form-item>
      #elseif($column.htmlType == "imageUpload")## 图片上传
    <el-form-item label="${comment}" prop="${javaField}">
      <UploadImg v-model="formData.${javaField}" />
    </el-form-item>
      #elseif($column.htmlType == "fileUpload")## 文件上传
    <el-form-item label="${comment}" prop="${javaField}">
      <UploadFile v-model="formData.${javaField}" />
    </el-form-item>
      #elseif($column.htmlType == "editor")## 文本编辑器
    <el-form-item label="${comment}" prop="${javaField}">
      <Editor v-model="formData.${javaField}" height="150px" />
    </el-form-item>
      #elseif($column.htmlType == "select")## 下拉框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-select v-model="formData.${javaField}" placeholder="请选择${comment}">
              #if ("" != $dictType)## 有数据字典
        <el-option
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.label"
          :value="dict.value"
        />
              #else##没数据字典
        <el-option label="请选择字典生成" value="" />
              #end
      </el-select>
    </el-form-item>
      #elseif($column.htmlType == "checkbox")## 多选框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-checkbox-group v-model="formData.${javaField}">
              #if ("" != $dictType)## 有数据字典
        <el-checkbox
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.label"
          :value="dict.value"
        />
              #else##没数据字典
        <el-checkbox label="请选择字典生成" />
              #end
      </el-checkbox-group>
    </el-form-item>
      #elseif($column.htmlType == "radio")## 单选框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-radio-group v-model="formData.${javaField}">
              #if ("" != $dictType)## 有数据字典
        <el-radio
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.value"
          >
          {{ dict.label }}
        </el-radio>
              #else##没数据字典
        <el-radio value="1">请选择字典生成</el-radio>
              #end
      </el-radio-group>
    </el-form-item>
      #elseif($column.htmlType == "datetime")## 时间框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-date-picker
        v-model="formData.${javaField}"
        type="date"
        value-format="x"
        placeholder="选择${comment}"
      />
    </el-form-item>
      #elseif($column.htmlType == "textarea")## 文本框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-input v-model="formData.${javaField}" type="textarea" placeholder="请输入${comment}" />
    </el-form-item>
      #end
  #end
#end
  </el-form>
#end
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'

const props = defineProps<{
  ${subJoinColumn.javaField}: undefined // ${subJoinColumn.columnComment}（主表的关联字段）
}>()
const formLoading = ref(false) // 表单的加载中
const formData = ref([])
const formRules = reactive({
#foreach ($column in $subColumns)
    #if (($column.createOperation || $column.updateOperation) && !$column.nullable && !${column.primaryKey})## 创建或者更新操作 && 要求非空 && 非主键
        #set($comment=$column.columnComment)
  $column.javaField: [{ required: true, message: \'${comment}不能为空\', trigger: #if($column.htmlType == \'select\')\'change\'#else\'blur\'#end }],
    #end
#end
})
const formRef = ref() // 表单 Ref

/** 监听主表的关联字段的变化，加载对应的子表数据 */
watch(
  () => props.${subJoinColumn.javaField},
  async (val) => {
    // 1. 重置表单
#if ( $subTable.subJoinMany )
    formData.value = []
#else
    formData.value = {
    #foreach ($column in $subColumns)
      #if ($column.createOperation || $column.updateOperation)
        #if ($column.htmlType == "checkbox")
      $column.javaField: [],
        #else
      $column.javaField: undefined,
        #end
      #end
    #end
    }
#end
    // 2. val 非空，则加载数据
    if (!val) {
      return;
    }
    try {
      formLoading.value = true
#if ( $subTable.subJoinMany )
      formData.value = await ${simpleClassName}Api.get${subSimpleClassName}ListBy${SubJoinColumnName}(val)
#else
      const data = await ${simpleClassName}Api.get${subSimpleClassName}By${SubJoinColumnName}(val)
      if (!data) {
        return
      }
      formData.value = data
#end
    } finally {
      formLoading.value = false
    }
  },
  { immediate: true }
)
#if ( $subTable.subJoinMany )

/** 新增按钮操作 */
const handleAdd = () => {
  const row = {
#foreach ($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
    $column.javaField: [],
      #else
    $column.javaField: undefined,
      #end
  #end
#end
  }
  row.${subJoinColumn.javaField} = props.${subJoinColumn.javaField}
  formData.value.push(row)
}

/** 删除按钮操作 */
const handleDelete = (index) => {
  formData.value.splice(index, 1)
}
#end

/** 表单校验 */
const validate = () => {
  return formRef.value.validate()
}

/** 表单值 */
const getData = () => {
  return formData.value
}

defineExpose({ validate, getData })
</script>
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:28', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (29, 1, 'vue3_sub_inner', 'vue3内嵌子表实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue3/views/components/form_sub_inner.vue.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
<template>
#if ( $subTable.subJoinMany )## 情况一：一对多，table + form
  <el-form
    ref="formRef"
    :model="formData"
    :rules="formRules"
    v-loading="formLoading"
    label-width="0px"
    :inline-message="true"
  >
    <el-table :data="formData" class="-mt-10px">
      <el-table-column label="序号" type="index" width="100" />
#foreach($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
        #set ($dictType = $column.dictType)
        #set ($javaField = $column.javaField)
        #set ($javaType = $column.javaType)
        #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment = $column.columnComment)
        #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
        #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
            #set ($dictMethod = "getIntDictOptions")
        #elseif ($javaType == "String")
            #set ($dictMethod = "getStrDictOptions")
        #elseif ($javaType == "Boolean")
            #set ($dictMethod = "getBoolDictOptions")
        #end
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-input v-model="row.${javaField}" placeholder="请输入${comment}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "imageUpload")## 图片上传
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <UploadImg v-model="row.${javaField}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "fileUpload")## 文件上传
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <UploadFile v-model="row.${javaField}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "editor")## 文本编辑器
      <el-table-column label="${comment}" min-width="400">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <Editor v-model="row.${javaField}" height="150px" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "select")## 下拉框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-select v-model="row.${javaField}" placeholder="请选择${comment}">
              #if ("" != $dictType)## 有数据字典
                <el-option
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              #else##没数据字典
                <el-option label="请选择字典生成" value="" />
              #end
            </el-select>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "checkbox")## 多选框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-checkbox-group v-model="row.${javaField}">
              #if ("" != $dictType)## 有数据字典
                <el-checkbox
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              #else##没数据字典
                <el-checkbox label="请选择字典生成" />
              #end
            </el-checkbox-group>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "radio")## 单选框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-radio-group v-model="row.${javaField}">
              #if ("" != $dictType)## 有数据字典
                <el-radio
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.value"
                >
                  {{ dict.label }}
                </el-radio>
              #else##没数据字典
                <el-radio value="1">请选择字典生成</el-radio>
              #end
            </el-radio-group>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "datetime")## 时间框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-date-picker
              v-model="row.${javaField}"
              type="date"
              value-format="x"
              placeholder="选择${comment}"
            />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "textarea")## 文本框
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-input v-model="row.${javaField}" type="textarea" placeholder="请输入${comment}" />
          </el-form-item>
        </template>
      </el-table-column>
        #end
    #end
#end
      <el-table-column align="center" fixed="right" label="操作" width="60">
        <template #default="{ $index }">
          <el-button @click="handleDelete($index)" link>—</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-form>
  <el-row justify="center" class="mt-3">
    <el-button @click="handleAdd" round>+ 添加${subTable.classComment}</el-button>
  </el-row>
#else## 情况二：一对一，form
  <el-form
    ref="formRef"
    :model="formData"
    :rules="formRules"
    label-width="100px"
    v-loading="formLoading"
  >
#foreach($column in $subColumns)
  #if ($column.createOperation || $column.updateOperation)
  #set ($dictType = $column.dictType)
      #set ($javaField = $column.javaField)
      #set ($javaType = $column.javaType)
      #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
      #set ($comment = $column.columnComment)
      #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
      #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
        #set ($dictMethod = "getIntDictOptions")
      #elseif ($javaType == "String")
          #set ($dictMethod = "getStrDictOptions")
      #elseif ($javaType == "Boolean")
          #set ($dictMethod = "getBoolDictOptions")
      #end
      #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
      #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
    <el-form-item label="${comment}" prop="${javaField}">
      <el-input v-model="formData.${javaField}" placeholder="请输入${comment}" />
    </el-form-item>
      #elseif($column.htmlType == "imageUpload")## 图片上传
    <el-form-item label="${comment}" prop="${javaField}">
      <UploadImg v-model="formData.${javaField}" />
    </el-form-item>
      #elseif($column.htmlType == "fileUpload")## 文件上传
    <el-form-item label="${comment}" prop="${javaField}">
      <UploadFile v-model="formData.${javaField}" />
    </el-form-item>
      #elseif($column.htmlType == "editor")## 文本编辑器
    <el-form-item label="${comment}" prop="${javaField}">
      <Editor v-model="formData.${javaField}" height="150px" />
    </el-form-item>
      #elseif($column.htmlType == "select")## 下拉框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-select v-model="formData.${javaField}" placeholder="请选择${comment}">
              #if ("" != $dictType)## 有数据字典
        <el-option
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.label"
          :value="dict.value"
        />
              #else##没数据字典
        <el-option label="请选择字典生成" value="" />
              #end
      </el-select>
    </el-form-item>
      #elseif($column.htmlType == "checkbox")## 多选框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-checkbox-group v-model="formData.${javaField}">
              #if ("" != $dictType)## 有数据字典
        <el-checkbox
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.label"
          :value="dict.value"
        />
              #else##没数据字典
        <el-checkbox label="请选择字典生成" />
              #end
      </el-checkbox-group>
    </el-form-item>
      #elseif($column.htmlType == "radio")## 单选框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-radio-group v-model="formData.${javaField}">
              #if ("" != $dictType)## 有数据字典
        <el-radio
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.value"
          >
          {{ dict.label }}
        </el-radio>
              #else##没数据字典
        <el-radio value="1">请选择字典生成</el-radio>
              #end
      </el-radio-group>
    </el-form-item>
      #elseif($column.htmlType == "datetime")## 时间框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-date-picker
        v-model="formData.${javaField}"
        type="date"
        value-format="x"
        placeholder="选择${comment}"
      />
    </el-form-item>
      #elseif($column.htmlType == "textarea")## 文本框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-input v-model="formData.${javaField}" type="textarea" placeholder="请输入${comment}" />
    </el-form-item>
      #end
  #end
#end
  </el-form>
#end
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'

const props = defineProps<{
  ${subJoinColumn.javaField}: undefined // ${subJoinColumn.columnComment}（主表的关联字段）
}>()
const formLoading = ref(false) // 表单的加载中
const formData = ref([])
const formRules = reactive({
#foreach ($column in $subColumns)
    #if (($column.createOperation || $column.updateOperation) && !$column.nullable && !${column.primaryKey})## 创建或者更新操作 && 要求非空 && 非主键
        #set($comment=$column.columnComment)
  $column.javaField: [{ required: true, message: \'${comment}不能为空\', trigger: #if($column.htmlType == \'select\')\'change\'#else\'blur\'#end }],
    #end
#end
})
const formRef = ref() // 表单 Ref

/** 监听主表的关联字段的变化，加载对应的子表数据 */
watch(
  () => props.${subJoinColumn.javaField},
  async (val) => {
    // 1. 重置表单
#if ( $subTable.subJoinMany )
    formData.value = []
#else
    formData.value = {
    #foreach ($column in $subColumns)
      #if ($column.createOperation || $column.updateOperation)
        #if ($column.htmlType == "checkbox")
      $column.javaField: [],
        #else
      $column.javaField: undefined,
        #end
      #end
    #end
    }
#end
    // 2. val 非空，则加载数据
    if (!val) {
      return;
    }
    try {
      formLoading.value = true
#if ( $subTable.subJoinMany )
      formData.value = await ${simpleClassName}Api.get${subSimpleClassName}ListBy${SubJoinColumnName}(val)
#else
      const data = await ${simpleClassName}Api.get${subSimpleClassName}By${SubJoinColumnName}(val)
      if (!data) {
        return
      }
      formData.value = data
#end
    } finally {
      formLoading.value = false
    }
  },
  { immediate: true }
)
#if ( $subTable.subJoinMany )

/** 新增按钮操作 */
const handleAdd = () => {
  const row = {
#foreach ($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
    $column.javaField: [],
      #else
    $column.javaField: undefined,
      #end
  #end
#end
  }
  row.${subJoinColumn.javaField} = props.${subJoinColumn.javaField}
  formData.value.push(row)
}

/** 删除按钮操作 */
const handleDelete = (index) => {
  formData.value.splice(index, 1)
}
#end

/** 表单校验 */
const validate = () => {
  return formRef.value.validate()
}

/** 表单值 */
const getData = () => {
  return formData.value
}

defineExpose({ validate, getData })
</script>
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:30', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (30, 1, 'vue3_form_sub_erp', 'vue3 erp实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue3/views/components/form_sub_erp.vue.vm', '#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
<template>
  <Dialog :title="dialogTitle" v-model="dialogVisible">
    <el-form
      ref="formRef"
      :model="formData"
      :rules="formRules"
      label-width="100px"
      v-loading="formLoading"
    >
#foreach($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
        #set ($dictType = $column.dictType)
        #set ($javaField = $column.javaField)
        #set ($javaType = $column.javaType)
        #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment = $column.columnComment)
        #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
        #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
            #set ($dictMethod = "getIntDictOptions")
        #elseif ($javaType == "String")
            #set ($dictMethod = "getStrDictOptions")
        #elseif ($javaType == "Boolean")
            #set ($dictMethod = "getBoolDictOptions")
        #end
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input v-model="formData.${javaField}" placeholder="请输入${comment}" />
      </el-form-item>
        #elseif($column.htmlType == "imageUpload")## 图片上传
      <el-form-item label="${comment}" prop="${javaField}">
        <UploadImg v-model="formData.${javaField}" />
      </el-form-item>
        #elseif($column.htmlType == "fileUpload")## 文件上传
      <el-form-item label="${comment}" prop="${javaField}">
        <UploadFile v-model="formData.${javaField}" />
      </el-form-item>
        #elseif($column.htmlType == "editor")## 文本编辑器
      <el-form-item label="${comment}" prop="${javaField}">
        <Editor v-model="formData.${javaField}" height="150px" />
      </el-form-item>
        #elseif($column.htmlType == "select")## 下拉框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-select v-model="formData.${javaField}" placeholder="请选择${comment}">
                #if ("" != $dictType)## 有数据字典
          <el-option
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else##没数据字典
          <el-option label="请选择字典生成" value="" />
                #end
        </el-select>
      </el-form-item>
        #elseif($column.htmlType == "checkbox")## 多选框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-checkbox-group v-model="formData.${javaField}">
                #if ("" != $dictType)## 有数据字典
          <el-checkbox
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else##没数据字典
          <el-checkbox label="请选择字典生成" />
                #end
        </el-checkbox-group>
      </el-form-item>
        #elseif($column.htmlType == "radio")## 单选框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-radio-group v-model="formData.${javaField}">
                #if ("" != $dictType)## 有数据字典
          <el-radio
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.value"
          >
            {{ dict.label }}
          </el-radio>
                #else##没数据字典
          <el-radio value="1">请选择字典生成</el-radio>
                #end
        </el-radio-group>
      </el-form-item>
        #elseif($column.htmlType == "datetime")## 时间框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-date-picker
          v-model="formData.${javaField}"
          type="date"
          value-format="x"
          placeholder="选择${comment}"
        />
      </el-form-item>
        #elseif($column.htmlType == "textarea")## 文本框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input v-model="formData.${javaField}" type="textarea" placeholder="请输入${comment}" />
      </el-form-item>
        #end
    #end
#end
    </el-form>
    <template #footer>
      <el-button @click="submitForm" type="primary" :disabled="formLoading">确 定</el-button>
      <el-button @click="dialogVisible = false">取 消</el-button>
    </template>
  </Dialog>
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const dialogVisible = ref(false) // 弹窗的是否展示
const dialogTitle = ref(\'\') // 弹窗的标题
const formLoading = ref(false) // 表单的加载中：1）修改时的数据加载；2）提交的按钮禁用
const formType = ref(\'\') // 表单的类型：create - 新增；update - 修改
const formData = ref({
#foreach ($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
  $column.javaField: [],
      #else
  $column.javaField: undefined,
      #end
    #end
#end
})
const formRules = reactive({
#foreach ($column in $subColumns)
    #if (($column.createOperation || $column.updateOperation) && !$column.nullable && !${column.primaryKey})## 创建或者更新操作 && 要求非空 && 非主键
        #set($comment=$column.columnComment)
  $column.javaField: [{ required: true, message: \'${comment}不能为空\', trigger: #if($column.htmlType == \'select\')\'change\'#else\'blur\'#end }],
    #end
#end
})
const formRef = ref() // 表单 Ref

/** 打开弹窗 */
const open = async (type: string, id?: number, ${subJoinColumn.javaField}: number) => {
  dialogVisible.value = true
  dialogTitle.value = t(\'action.\' + type)
  formType.value = type
  resetForm()
  formData.value.${subJoinColumn.javaField} = ${subJoinColumn.javaField}
  // 修改时，设置数据
  if (id) {
    formLoading.value = true
    try {
      formData.value = await ${simpleClassName}Api.get${subSimpleClassName}(id)
    } finally {
      formLoading.value = false
    }
  }
}
defineExpose({ open }) // 提供 open 方法，用于打开弹窗

/** 提交表单 */
const emit = defineEmits([\'success\']) // 定义 success 事件，用于操作成功后的回调
const submitForm = async () => {
  // 校验表单
  await formRef.value.validate()
  // 提交请求
  formLoading.value = true
  try {
    const data = formData.value
    if (formType.value === \'create\') {
      await ${simpleClassName}Api.create${subSimpleClassName}(data)
      message.success(t(\'common.createSuccess\'))
    } else {
      await ${simpleClassName}Api.update${subSimpleClassName}(data)
      message.success(t(\'common.updateSuccess\'))
    }
    dialogVisible.value = false
    // 发送操作成功的事件
    emit(\'success\')
  } finally {
    formLoading.value = false
  }
}

/** 重置表单 */
const resetForm = () => {
  formData.value = {
#foreach ($column in $subColumns)
  #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
    $column.javaField: [],
      #else
    $column.javaField: undefined,
      #end
  #end
#end
  }
  formRef.value?.resetFields()
}
</script>
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:32', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (31, 1, 'vue3_list_sub_inner.vue', 'vue3内嵌list实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}List.vue', 'codegen/vue3/views/components/list_sub_inner.vue.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
<template>
  <!-- 列表 -->
  <ContentWrap>
#if ($table.templateType == 11)
    <el-button
      type="primary"
      plain
      @click="openForm(\'create\')"
      v-hasPermi="[\'${permissionPrefix}:create\']"
    >
      <Icon icon="ep:plus" class="mr-5px" /> 新增
    </el-button>
#end
    <el-table v-loading="loading" :data="list" :stripe="true" :show-overflow-tooltip="true">
      #foreach($column in $subColumns)
      #if ($column.listOperationResult)
        #set ($dictType=$column.dictType)
        #set ($javaField = $column.javaField)
        #set ($AttrName=$column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment=$column.columnComment)
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.javaType == "LocalDateTime")## 时间类型
      <el-table-column
        label="${comment}"
        align="center"
        prop="${javaField}"
        :formatter="dateFormatter"
        width="180px"
      />
        #elseif($column.dictType && "" != $column.dictType)## 数据字典
      <el-table-column label="${comment}" align="center" prop="${javaField}">
        <template #default="scope">
          <dict-tag :type="DICT_TYPE.$dictType.toUpperCase()" :value="scope.row.${column.javaField}" />
        </template>
      </el-table-column>
        #else
      <el-table-column label="${comment}" align="center" prop="${javaField}" />
        #end
      #end
    #end
    #if ($table.templateType == 11)
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="openForm(\'update\', scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:update\']"
          >
            编辑
          </el-button>
          <el-button
            link
            type="danger"
            @click="handleDelete(scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:delete\']"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    #end
    </el-table>
    #if ($table.templateType == 11)
    <!-- 分页 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
    #end
  </ContentWrap>
#if ($table.templateType == 11)
    <!-- 表单弹窗：添加/修改 -->
    <${subSimpleClassName}Form ref="formRef" @success="getList" />
#end
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { dateFormatter } from \'@/utils/formatTime\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'
#if ($table.templateType == 11)
import ${subSimpleClassName}Form from \'./${subSimpleClassName}Form.vue\'
#end

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const props = defineProps<{
  ${subJoinColumn.javaField}?: number // ${subJoinColumn.columnComment}（主表的关联字段）
}>()
const loading = ref(false) // 列表的加载中
const list = ref([]) // 列表的数据
#if ($table.templateType == 11)
const total = ref(0) // 列表的总页数
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  ${subJoinColumn.javaField}: undefined as unknown
})

/** 监听主表的关联字段的变化，加载对应的子表数据 */
watch(
  () => props.${subJoinColumn.javaField},
  (val: number) => {
    if (!val) {
      return
    }
    queryParams.${subJoinColumn.javaField} = val
    handleQuery()
  },
    { immediate: true, deep: true }
)
#end

/** 查询列表 */
const getList = async () => {
  loading.value = true
  try {
#if ($table.templateType == 11)
    const data = await ${simpleClassName}Api.get${subSimpleClassName}Page(queryParams)
    list.value = data.list
    total.value = data.total
#else
  #if ( $subTable.subJoinMany )
    list.value = await ${simpleClassName}Api.get${subSimpleClassName}ListBy${SubJoinColumnName}(props.${subJoinColumn.javaField})
  #else
    const data = await ${simpleClassName}Api.get${subSimpleClassName}By${SubJoinColumnName}(props.${subJoinColumn.javaField})
    if (!data) {
      return
    }
    list.value.push(data)
  #end
#end
  } finally {
    loading.value = false
  }
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.pageNo = 1
  getList()
}
#if ($table.templateType == 11)

/** 添加/修改操作 */
const formRef = ref()
const openForm = (type: string, id?: number) => {
  if (!props.${subJoinColumn.javaField}) {
    message.error(\'请选择一个${table.classComment}\')
    return
  }
  formRef.value.open(type, id, props.${subJoinColumn.javaField})
}

/** 删除按钮操作 */
const handleDelete = async (id: number) => {
  try {
    // 删除的二次确认
    await message.delConfirm()
    // 发起删除
    await ${simpleClassName}Api.delete${subSimpleClassName}(id)
    message.success(t(\'common.delSuccess\'))
    // 刷新列表
    await getList()
  } catch {}
}
#end
#if ($table.templateType != 11)

/** 初始化 **/
onMounted(() => {
  getList()
})
#end
</script>
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:34', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (32, 1, 'vue3_ list_sub_erp.vue', 'vue3list子表erp实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}List.vue', 'codegen/vue3/views/components/list_sub_erp.vue.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
<template>
  <!-- 列表 -->
  <ContentWrap>
#if ($table.templateType == 11)
    <el-button
      type="primary"
      plain
      @click="openForm(\'create\')"
      v-hasPermi="[\'${permissionPrefix}:create\']"
    >
      <Icon icon="ep:plus" class="mr-5px" /> 新增
    </el-button>
#end
    <el-table v-loading="loading" :data="list" :stripe="true" :show-overflow-tooltip="true">
      #foreach($column in $subColumns)
      #if ($column.listOperationResult)
        #set ($dictType=$column.dictType)
        #set ($javaField = $column.javaField)
        #set ($AttrName=$column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment=$column.columnComment)
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.javaType == "LocalDateTime")## 时间类型
      <el-table-column
        label="${comment}"
        align="center"
        prop="${javaField}"
        :formatter="dateFormatter"
        width="180px"
      />
        #elseif($column.dictType && "" != $column.dictType)## 数据字典
      <el-table-column label="${comment}" align="center" prop="${javaField}">
        <template #default="scope">
          <dict-tag :type="DICT_TYPE.$dictType.toUpperCase()" :value="scope.row.${column.javaField}" />
        </template>
      </el-table-column>
        #else
      <el-table-column label="${comment}" align="center" prop="${javaField}" />
        #end
      #end
    #end
    #if ($table.templateType == 11)
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="openForm(\'update\', scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:update\']"
          >
            编辑
          </el-button>
          <el-button
            link
            type="danger"
            @click="handleDelete(scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:delete\']"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    #end
    </el-table>
    #if ($table.templateType == 11)
    <!-- 分页 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
    #end
  </ContentWrap>
#if ($table.templateType == 11)
    <!-- 表单弹窗：添加/修改 -->
    <${subSimpleClassName}Form ref="formRef" @success="getList" />
#end
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { dateFormatter } from \'@/utils/formatTime\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'
#if ($table.templateType == 11)
import ${subSimpleClassName}Form from \'./${subSimpleClassName}Form.vue\'
#end

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const props = defineProps<{
  ${subJoinColumn.javaField}?: number // ${subJoinColumn.columnComment}（主表的关联字段）
}>()
const loading = ref(false) // 列表的加载中
const list = ref([]) // 列表的数据
#if ($table.templateType == 11)
const total = ref(0) // 列表的总页数
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  ${subJoinColumn.javaField}: undefined as unknown
})

/** 监听主表的关联字段的变化，加载对应的子表数据 */
watch(
  () => props.${subJoinColumn.javaField},
  (val: number) => {
    if (!val) {
      return
    }
    queryParams.${subJoinColumn.javaField} = val
    handleQuery()
  },
    { immediate: true, deep: true }
)
#end

/** 查询列表 */
const getList = async () => {
  loading.value = true
  try {
#if ($table.templateType == 11)
    const data = await ${simpleClassName}Api.get${subSimpleClassName}Page(queryParams)
    list.value = data.list
    total.value = data.total
#else
  #if ( $subTable.subJoinMany )
    list.value = await ${simpleClassName}Api.get${subSimpleClassName}ListBy${SubJoinColumnName}(props.${subJoinColumn.javaField})
  #else
    const data = await ${simpleClassName}Api.get${subSimpleClassName}By${SubJoinColumnName}(props.${subJoinColumn.javaField})
    if (!data) {
      return
    }
    list.value.push(data)
  #end
#end
  } finally {
    loading.value = false
  }
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.pageNo = 1
  getList()
}
#if ($table.templateType == 11)

/** 添加/修改操作 */
const formRef = ref()
const openForm = (type: string, id?: number) => {
  if (!props.${subJoinColumn.javaField}) {
    message.error(\'请选择一个${table.classComment}\')
    return
  }
  formRef.value.open(type, id, props.${subJoinColumn.javaField})
}

/** 删除按钮操作 */
const handleDelete = async (id: number) => {
  try {
    // 删除的二次确认
    await message.delConfirm()
    // 发起删除
    await ${simpleClassName}Api.delete${subSimpleClassName}(id)
    message.success(t(\'common.delSuccess\'))
    // 刷新列表
    await getList()
  } catch {}
}
#end
#if ($table.templateType != 11)

/** 初始化 **/
onMounted(() => {
  getList()
})
#end
</script>
', '1', '2024-12-15 07:32:09', '1', '2024-12-16 14:36:37', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (33, 1, 'vue3_api', 'vue3版本api实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/api/${table.moduleName}/${table.businessName}/index.ts', 'codegen/vue3/api/api.ts.vm', 'import request from \'@/config/axios\'
#set ($baseURL = "/${table.moduleName}/${simpleClassName_strikeCase}")

// ${table.classComment} VO
export interface ${simpleClassName}VO {
#foreach ($column in $columns)
#if ($column.createOperation || $column.updateOperation)
#if(${column.javaType.toLowerCase()} == "long" || ${column.javaType.toLowerCase()} == "integer" || ${column.javaType.toLowerCase()} == "short" || ${column.javaType.toLowerCase()} == "double" || ${column.javaType.toLowerCase()} == "bigdecimal")
  ${column.javaField}: number // ${column.columnComment}
#elseif(${column.javaType.toLowerCase()} == "date" || ${column.javaType.toLowerCase()} == "localdate" || ${column.javaType.toLowerCase()} == "localdatetime")
  ${column.javaField}: Date // ${column.columnComment}
#else
  ${column.javaField}: ${column.javaType.toLowerCase()} // ${column.columnComment}
#end
#end
#end
}

// ${table.classComment} API
export const ${simpleClassName}Api = {
#if ( $table.templateType != 2 )
  // 查询${table.classComment}分页
  get${simpleClassName}Page: async (params: any) => {
    return await request.get({ url: `${baseURL}/page`, params })
  },
#else
  // 查询${table.classComment}列表
  get${simpleClassName}List: async (params) => {
    return await request.get({ url: `${baseURL}/list`, params })
  },
#end

  // 查询${table.classComment}详情
  get${simpleClassName}: async (id: number) => {
    return await request.get({ url: `${baseURL}/get?id=` + id })
  },

  // 新增${table.classComment}
  create${simpleClassName}: async (data: ${simpleClassName}VO) => {
    return await request.post({ url: `${baseURL}/create`, data })
  },

  // 修改${table.classComment}
  update${simpleClassName}: async (data: ${simpleClassName}VO) => {
    return await request.put({ url: `${baseURL}/update`, data })
  },

  // 删除${table.classComment}
  delete${simpleClassName}: async (id: number) => {
    return await request.delete({ url: `${baseURL}/delete?id=` + id })
  },

  // 导出${table.classComment} Excel
  export${simpleClassName}: async (params) => {
    return await request.download({ url: `${baseURL}/export-excel`, params })
  },
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subPrimaryColumn = $subPrimaryColumns.get($index))##当前 primary 字段
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
#set ($subSimpleClassName_strikeCase = $subSimpleClassName_strikeCases.get($index))
#set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
#set ($subClassNameVar = $subClassNameVars.get($index))

// ==================== 子表（$subTable.classComment） ====================
## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )

  // 获得${subTable.classComment}分页
  get${subSimpleClassName}Page: async (params) => {
    return await request.get({ url: `${baseURL}/${subSimpleClassName_strikeCase}/page`, params })
  },
## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
  #if ( $subTable.subJoinMany )

  // 获得${subTable.classComment}列表
  get${subSimpleClassName}ListBy${SubJoinColumnName}: async (${subJoinColumn.javaField}) => {
    return await request.get({ url: `${baseURL}/${subSimpleClassName_strikeCase}/list-by-${subJoinColumn_strikeCase}?${subJoinColumn.javaField}=` + ${subJoinColumn.javaField} })
  },
  #else

  // 获得${subTable.classComment}
  get${subSimpleClassName}By${SubJoinColumnName}: async (${subJoinColumn.javaField}) => {
    return await request.get({ url: `${baseURL}/${subSimpleClassName_strikeCase}/get-by-${subJoinColumn_strikeCase}?${subJoinColumn.javaField}=` + ${subJoinColumn.javaField} })
  },
  #end
#end
## 特殊：MASTER_ERP 时，支持单个的新增、修改、删除操作
#if ( $table.templateType == 11 )
  // 新增${subTable.classComment}
  create${subSimpleClassName}: async (data) => {
    return await request.post({ url: `${baseURL}/${subSimpleClassName_strikeCase}/create`, data })
  },

  // 修改${subTable.classComment}
  update${subSimpleClassName}: async (data) => {
    return await request.put({ url: `${baseURL}/${subSimpleClassName_strikeCase}/update`, data })
  },

  // 删除${subTable.classComment}
  delete${subSimpleClassName}: async (id: number) => {
    return await request.delete({ url: `${baseURL}/${subSimpleClassName_strikeCase}/delete?id=` + id })
  },

  // 获得${subTable.classComment}
  get${subSimpleClassName}: async (id: number) => {
    return await request.get({ url: `${baseURL}/${subSimpleClassName_strikeCase}/get?id=` + id })
  },
#end
#end
}

', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:46:54', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (34, 1, '', '', 'FRONT', 'VUE3_VBEN', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/${classNameVar}.data.ts', 'codegen/vue3_vben/views/data.ts.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:47:20', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (35, 1, '', '', 'FRONT', 'VUE3_VBEN', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/index.vue', 'codegen/vue3_vben/views/index.vue.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:47:20', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (36, 1, '', '', 'FRONT', 'VUE3_VBEN', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/${simpleClassName}Modal.vue', 'codegen/vue3_vben/views/form.vue.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:47:20', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (37, 1, '', '', 'FRONT', 'VUE3_VBEN', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/api/${table.moduleName}/${table.businessName}/index.ts', 'codegen/vue3_vben/api/api.ts.vm', '', '1', '2024-12-15 07:32:09', '1', '2024-12-15 11:47:20', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (38, 3, '', '', 'FRONT', 'VUE3_VBEN', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/api/${table.moduleName}/${table.businessName}/index.ts', 'codegen/vue3_vben/api/api.ts.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (39, 3, '', '', 'FRONT', 'VUE3_VBEN', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/${simpleClassName}Modal.vue', 'codegen/vue3_vben/views/form.vue.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (40, 3, '', '', 'FRONT', 'VUE3_VBEN', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/index.vue', 'codegen/vue3_vben/views/index.vue.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (41, 3, '', '', 'FRONT', 'VUE3_VBEN', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/${classNameVar}.data.ts', 'codegen/vue3_vben/views/data.ts.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (42, 3, 'vue3_api', 'vue3版本api实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/api/${table.moduleName}/${table.businessName}/index.ts', 'codegen/vue3/api/api.ts.vm', 'import request from \'@/config/axios\'
#set ($baseURL = "/${table.moduleName}/${simpleClassName_strikeCase}")

// ${table.classComment} VO
export interface ${simpleClassName}VO {
#foreach ($column in $columns)
#if ($column.createOperation || $column.updateOperation)
#if(${column.javaType.toLowerCase()} == "long" || ${column.javaType.toLowerCase()} == "integer" || ${column.javaType.toLowerCase()} == "short" || ${column.javaType.toLowerCase()} == "double" || ${column.javaType.toLowerCase()} == "bigdecimal")
  ${column.javaField}: number // ${column.columnComment}
#elseif(${column.javaType.toLowerCase()} == "date" || ${column.javaType.toLowerCase()} == "localdate" || ${column.javaType.toLowerCase()} == "localdatetime")
  ${column.javaField}: Date // ${column.columnComment}
#else
  ${column.javaField}: ${column.javaType.toLowerCase()} // ${column.columnComment}
#end
#end
#end
}

// ${table.classComment} API
export const ${simpleClassName}Api = {
#if ( $table.templateType != 2 )
  // 查询${table.classComment}分页
  get${simpleClassName}Page: async (params: any) => {
    return await request.get({ url: `${baseURL}/page`, params })
  },
#else
  // 查询${table.classComment}列表
  get${simpleClassName}List: async (params) => {
    return await request.get({ url: `${baseURL}/list`, params })
  },
#end

  // 查询${table.classComment}详情
  get${simpleClassName}: async (id: number) => {
    return await request.get({ url: `${baseURL}/get?id=` + id })
  },

  // 新增${table.classComment}
  create${simpleClassName}: async (data: ${simpleClassName}VO) => {
    return await request.post({ url: `${baseURL}/create`, data })
  },

  // 修改${table.classComment}
  update${simpleClassName}: async (data: ${simpleClassName}VO) => {
    return await request.put({ url: `${baseURL}/update`, data })
  },

  // 删除${table.classComment}
  delete${simpleClassName}: async (id: number) => {
    return await request.delete({ url: `${baseURL}/delete?id=` + id })
  },

  // 导出${table.classComment} Excel
  export${simpleClassName}: async (params) => {
    return await request.download({ url: `${baseURL}/export-excel`, params })
  },
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subPrimaryColumn = $subPrimaryColumns.get($index))##当前 primary 字段
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
#set ($subSimpleClassName_strikeCase = $subSimpleClassName_strikeCases.get($index))
#set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
#set ($subClassNameVar = $subClassNameVars.get($index))

// ==================== 子表（$subTable.classComment） ====================
## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )

  // 获得${subTable.classComment}分页
  get${subSimpleClassName}Page: async (params) => {
    return await request.get({ url: `${baseURL}/${subSimpleClassName_strikeCase}/page`, params })
  },
## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
  #if ( $subTable.subJoinMany )

  // 获得${subTable.classComment}列表
  get${subSimpleClassName}ListBy${SubJoinColumnName}: async (${subJoinColumn.javaField}) => {
    return await request.get({ url: `${baseURL}/${subSimpleClassName_strikeCase}/list-by-${subJoinColumn_strikeCase}?${subJoinColumn.javaField}=` + ${subJoinColumn.javaField} })
  },
  #else

  // 获得${subTable.classComment}
  get${subSimpleClassName}By${SubJoinColumnName}: async (${subJoinColumn.javaField}) => {
    return await request.get({ url: `${baseURL}/${subSimpleClassName_strikeCase}/get-by-${subJoinColumn_strikeCase}?${subJoinColumn.javaField}=` + ${subJoinColumn.javaField} })
  },
  #end
#end
## 特殊：MASTER_ERP 时，支持单个的新增、修改、删除操作
#if ( $table.templateType == 11 )
  // 新增${subTable.classComment}
  create${subSimpleClassName}: async (data) => {
    return await request.post({ url: `${baseURL}/${subSimpleClassName_strikeCase}/create`, data })
  },

  // 修改${subTable.classComment}
  update${subSimpleClassName}: async (data) => {
    return await request.put({ url: `${baseURL}/${subSimpleClassName_strikeCase}/update`, data })
  },

  // 删除${subTable.classComment}
  delete${subSimpleClassName}: async (id: number) => {
    return await request.delete({ url: `${baseURL}/${subSimpleClassName_strikeCase}/delete?id=` + id })
  },

  // 获得${subTable.classComment}
  get${subSimpleClassName}: async (id: number) => {
    return await request.get({ url: `${baseURL}/${subSimpleClassName_strikeCase}/get?id=` + id })
  },
#end
#end
}

', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (43, 3, 'vue3_ list_sub_erp.vue', 'vue3list子表erp实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}List.vue', 'codegen/vue3/views/components/list_sub_erp.vue.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
<template>
  <!-- 列表 -->
  <ContentWrap>
#if ($table.templateType == 11)
    <el-button
      type="primary"
      plain
      @click="openForm(\'create\')"
      v-hasPermi="[\'${permissionPrefix}:create\']"
    >
      <Icon icon="ep:plus" class="mr-5px" /> 新增
    </el-button>
#end
    <el-table v-loading="loading" :data="list" :stripe="true" :show-overflow-tooltip="true">
      #foreach($column in $subColumns)
      #if ($column.listOperationResult)
        #set ($dictType=$column.dictType)
        #set ($javaField = $column.javaField)
        #set ($AttrName=$column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment=$column.columnComment)
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.javaType == "LocalDateTime")## 时间类型
      <el-table-column
        label="${comment}"
        align="center"
        prop="${javaField}"
        :formatter="dateFormatter"
        width="180px"
      />
        #elseif($column.dictType && "" != $column.dictType)## 数据字典
      <el-table-column label="${comment}" align="center" prop="${javaField}">
        <template #default="scope">
          <dict-tag :type="DICT_TYPE.$dictType.toUpperCase()" :value="scope.row.${column.javaField}" />
        </template>
      </el-table-column>
        #else
      <el-table-column label="${comment}" align="center" prop="${javaField}" />
        #end
      #end
    #end
    #if ($table.templateType == 11)
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="openForm(\'update\', scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:update\']"
          >
            编辑
          </el-button>
          <el-button
            link
            type="danger"
            @click="handleDelete(scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:delete\']"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    #end
    </el-table>
    #if ($table.templateType == 11)
    <!-- 分页 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
    #end
  </ContentWrap>
#if ($table.templateType == 11)
    <!-- 表单弹窗：添加/修改 -->
    <${subSimpleClassName}Form ref="formRef" @success="getList" />
#end
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { dateFormatter } from \'@/utils/formatTime\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'
#if ($table.templateType == 11)
import ${subSimpleClassName}Form from \'./${subSimpleClassName}Form.vue\'
#end

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const props = defineProps<{
  ${subJoinColumn.javaField}?: number // ${subJoinColumn.columnComment}（主表的关联字段）
}>()
const loading = ref(false) // 列表的加载中
const list = ref([]) // 列表的数据
#if ($table.templateType == 11)
const total = ref(0) // 列表的总页数
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  ${subJoinColumn.javaField}: undefined as unknown
})

/** 监听主表的关联字段的变化，加载对应的子表数据 */
watch(
  () => props.${subJoinColumn.javaField},
  (val: number) => {
    if (!val) {
      return
    }
    queryParams.${subJoinColumn.javaField} = val
    handleQuery()
  },
    { immediate: true, deep: true }
)
#end

/** 查询列表 */
const getList = async () => {
  loading.value = true
  try {
#if ($table.templateType == 11)
    const data = await ${simpleClassName}Api.get${subSimpleClassName}Page(queryParams)
    list.value = data.list
    total.value = data.total
#else
  #if ( $subTable.subJoinMany )
    list.value = await ${simpleClassName}Api.get${subSimpleClassName}ListBy${SubJoinColumnName}(props.${subJoinColumn.javaField})
  #else
    const data = await ${simpleClassName}Api.get${subSimpleClassName}By${SubJoinColumnName}(props.${subJoinColumn.javaField})
    if (!data) {
      return
    }
    list.value.push(data)
  #end
#end
  } finally {
    loading.value = false
  }
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.pageNo = 1
  getList()
}
#if ($table.templateType == 11)

/** 添加/修改操作 */
const formRef = ref()
const openForm = (type: string, id?: number) => {
  if (!props.${subJoinColumn.javaField}) {
    message.error(\'请选择一个${table.classComment}\')
    return
  }
  formRef.value.open(type, id, props.${subJoinColumn.javaField})
}

/** 删除按钮操作 */
const handleDelete = async (id: number) => {
  try {
    // 删除的二次确认
    await message.delConfirm()
    // 发起删除
    await ${simpleClassName}Api.delete${subSimpleClassName}(id)
    message.success(t(\'common.delSuccess\'))
    // 刷新列表
    await getList()
  } catch {}
}
#end
#if ($table.templateType != 11)

/** 初始化 **/
onMounted(() => {
  getList()
})
#end
</script>
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (44, 3, 'vue3_list_sub_inner.vue', 'vue3内嵌list实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}List.vue', 'codegen/vue3/views/components/list_sub_inner.vue.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
<template>
  <!-- 列表 -->
  <ContentWrap>
#if ($table.templateType == 11)
    <el-button
      type="primary"
      plain
      @click="openForm(\'create\')"
      v-hasPermi="[\'${permissionPrefix}:create\']"
    >
      <Icon icon="ep:plus" class="mr-5px" /> 新增
    </el-button>
#end
    <el-table v-loading="loading" :data="list" :stripe="true" :show-overflow-tooltip="true">
      #foreach($column in $subColumns)
      #if ($column.listOperationResult)
        #set ($dictType=$column.dictType)
        #set ($javaField = $column.javaField)
        #set ($AttrName=$column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment=$column.columnComment)
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.javaType == "LocalDateTime")## 时间类型
      <el-table-column
        label="${comment}"
        align="center"
        prop="${javaField}"
        :formatter="dateFormatter"
        width="180px"
      />
        #elseif($column.dictType && "" != $column.dictType)## 数据字典
      <el-table-column label="${comment}" align="center" prop="${javaField}">
        <template #default="scope">
          <dict-tag :type="DICT_TYPE.$dictType.toUpperCase()" :value="scope.row.${column.javaField}" />
        </template>
      </el-table-column>
        #else
      <el-table-column label="${comment}" align="center" prop="${javaField}" />
        #end
      #end
    #end
    #if ($table.templateType == 11)
      <el-table-column label="操作" align="center">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="openForm(\'update\', scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:update\']"
          >
            编辑
          </el-button>
          <el-button
            link
            type="danger"
            @click="handleDelete(scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:delete\']"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    #end
    </el-table>
    #if ($table.templateType == 11)
    <!-- 分页 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
    #end
  </ContentWrap>
#if ($table.templateType == 11)
    <!-- 表单弹窗：添加/修改 -->
    <${subSimpleClassName}Form ref="formRef" @success="getList" />
#end
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { dateFormatter } from \'@/utils/formatTime\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'
#if ($table.templateType == 11)
import ${subSimpleClassName}Form from \'./${subSimpleClassName}Form.vue\'
#end

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const props = defineProps<{
  ${subJoinColumn.javaField}?: number // ${subJoinColumn.columnComment}（主表的关联字段）
}>()
const loading = ref(false) // 列表的加载中
const list = ref([]) // 列表的数据
#if ($table.templateType == 11)
const total = ref(0) // 列表的总页数
const queryParams = reactive({
  pageNo: 1,
  pageSize: 10,
  ${subJoinColumn.javaField}: undefined as unknown
})

/** 监听主表的关联字段的变化，加载对应的子表数据 */
watch(
  () => props.${subJoinColumn.javaField},
  (val: number) => {
    if (!val) {
      return
    }
    queryParams.${subJoinColumn.javaField} = val
    handleQuery()
  },
    { immediate: true, deep: true }
)
#end

/** 查询列表 */
const getList = async () => {
  loading.value = true
  try {
#if ($table.templateType == 11)
    const data = await ${simpleClassName}Api.get${subSimpleClassName}Page(queryParams)
    list.value = data.list
    total.value = data.total
#else
  #if ( $subTable.subJoinMany )
    list.value = await ${simpleClassName}Api.get${subSimpleClassName}ListBy${SubJoinColumnName}(props.${subJoinColumn.javaField})
  #else
    const data = await ${simpleClassName}Api.get${subSimpleClassName}By${SubJoinColumnName}(props.${subJoinColumn.javaField})
    if (!data) {
      return
    }
    list.value.push(data)
  #end
#end
  } finally {
    loading.value = false
  }
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.pageNo = 1
  getList()
}
#if ($table.templateType == 11)

/** 添加/修改操作 */
const formRef = ref()
const openForm = (type: string, id?: number) => {
  if (!props.${subJoinColumn.javaField}) {
    message.error(\'请选择一个${table.classComment}\')
    return
  }
  formRef.value.open(type, id, props.${subJoinColumn.javaField})
}

/** 删除按钮操作 */
const handleDelete = async (id: number) => {
  try {
    // 删除的二次确认
    await message.delConfirm()
    // 发起删除
    await ${simpleClassName}Api.delete${subSimpleClassName}(id)
    message.success(t(\'common.delSuccess\'))
    // 刷新列表
    await getList()
  } catch {}
}
#end
#if ($table.templateType != 11)

/** 初始化 **/
onMounted(() => {
  getList()
})
#end
</script>
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (45, 3, 'vue3_form_sub_erp', 'vue3 erp实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue3/views/components/form_sub_erp.vue.vm', '#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
<template>
  <Dialog :title="dialogTitle" v-model="dialogVisible">
    <el-form
      ref="formRef"
      :model="formData"
      :rules="formRules"
      label-width="100px"
      v-loading="formLoading"
    >
#foreach($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
        #set ($dictType = $column.dictType)
        #set ($javaField = $column.javaField)
        #set ($javaType = $column.javaType)
        #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment = $column.columnComment)
        #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
        #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
            #set ($dictMethod = "getIntDictOptions")
        #elseif ($javaType == "String")
            #set ($dictMethod = "getStrDictOptions")
        #elseif ($javaType == "Boolean")
            #set ($dictMethod = "getBoolDictOptions")
        #end
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input v-model="formData.${javaField}" placeholder="请输入${comment}" />
      </el-form-item>
        #elseif($column.htmlType == "imageUpload")## 图片上传
      <el-form-item label="${comment}" prop="${javaField}">
        <UploadImg v-model="formData.${javaField}" />
      </el-form-item>
        #elseif($column.htmlType == "fileUpload")## 文件上传
      <el-form-item label="${comment}" prop="${javaField}">
        <UploadFile v-model="formData.${javaField}" />
      </el-form-item>
        #elseif($column.htmlType == "editor")## 文本编辑器
      <el-form-item label="${comment}" prop="${javaField}">
        <Editor v-model="formData.${javaField}" height="150px" />
      </el-form-item>
        #elseif($column.htmlType == "select")## 下拉框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-select v-model="formData.${javaField}" placeholder="请选择${comment}">
                #if ("" != $dictType)## 有数据字典
          <el-option
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else##没数据字典
          <el-option label="请选择字典生成" value="" />
                #end
        </el-select>
      </el-form-item>
        #elseif($column.htmlType == "checkbox")## 多选框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-checkbox-group v-model="formData.${javaField}">
                #if ("" != $dictType)## 有数据字典
          <el-checkbox
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else##没数据字典
          <el-checkbox label="请选择字典生成" />
                #end
        </el-checkbox-group>
      </el-form-item>
        #elseif($column.htmlType == "radio")## 单选框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-radio-group v-model="formData.${javaField}">
                #if ("" != $dictType)## 有数据字典
          <el-radio
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.value"
          >
            {{ dict.label }}
          </el-radio>
                #else##没数据字典
          <el-radio value="1">请选择字典生成</el-radio>
                #end
        </el-radio-group>
      </el-form-item>
        #elseif($column.htmlType == "datetime")## 时间框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-date-picker
          v-model="formData.${javaField}"
          type="date"
          value-format="x"
          placeholder="选择${comment}"
        />
      </el-form-item>
        #elseif($column.htmlType == "textarea")## 文本框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input v-model="formData.${javaField}" type="textarea" placeholder="请输入${comment}" />
      </el-form-item>
        #end
    #end
#end
    </el-form>
    <template #footer>
      <el-button @click="submitForm" type="primary" :disabled="formLoading">确 定</el-button>
      <el-button @click="dialogVisible = false">取 消</el-button>
    </template>
  </Dialog>
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const dialogVisible = ref(false) // 弹窗的是否展示
const dialogTitle = ref(\'\') // 弹窗的标题
const formLoading = ref(false) // 表单的加载中：1）修改时的数据加载；2）提交的按钮禁用
const formType = ref(\'\') // 表单的类型：create - 新增；update - 修改
const formData = ref({
#foreach ($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
  $column.javaField: [],
      #else
  $column.javaField: undefined,
      #end
    #end
#end
})
const formRules = reactive({
#foreach ($column in $subColumns)
    #if (($column.createOperation || $column.updateOperation) && !$column.nullable && !${column.primaryKey})## 创建或者更新操作 && 要求非空 && 非主键
        #set($comment=$column.columnComment)
  $column.javaField: [{ required: true, message: \'${comment}不能为空\', trigger: #if($column.htmlType == \'select\')\'change\'#else\'blur\'#end }],
    #end
#end
})
const formRef = ref() // 表单 Ref

/** 打开弹窗 */
const open = async (type: string, id?: number, ${subJoinColumn.javaField}: number) => {
  dialogVisible.value = true
  dialogTitle.value = t(\'action.\' + type)
  formType.value = type
  resetForm()
  formData.value.${subJoinColumn.javaField} = ${subJoinColumn.javaField}
  // 修改时，设置数据
  if (id) {
    formLoading.value = true
    try {
      formData.value = await ${simpleClassName}Api.get${subSimpleClassName}(id)
    } finally {
      formLoading.value = false
    }
  }
}
defineExpose({ open }) // 提供 open 方法，用于打开弹窗

/** 提交表单 */
const emit = defineEmits([\'success\']) // 定义 success 事件，用于操作成功后的回调
const submitForm = async () => {
  // 校验表单
  await formRef.value.validate()
  // 提交请求
  formLoading.value = true
  try {
    const data = formData.value
    if (formType.value === \'create\') {
      await ${simpleClassName}Api.create${subSimpleClassName}(data)
      message.success(t(\'common.createSuccess\'))
    } else {
      await ${simpleClassName}Api.update${subSimpleClassName}(data)
      message.success(t(\'common.updateSuccess\'))
    }
    dialogVisible.value = false
    // 发送操作成功的事件
    emit(\'success\')
  } finally {
    formLoading.value = false
  }
}

/** 重置表单 */
const resetForm = () => {
  formData.value = {
#foreach ($column in $subColumns)
  #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
    $column.javaField: [],
      #else
    $column.javaField: undefined,
      #end
  #end
#end
  }
  formRef.value?.resetFields()
}
</script>
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (46, 3, 'vue3_sub_inner', 'vue3内嵌子表实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue3/views/components/form_sub_inner.vue.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
<template>
#if ( $subTable.subJoinMany )## 情况一：一对多，table + form
  <el-form
    ref="formRef"
    :model="formData"
    :rules="formRules"
    v-loading="formLoading"
    label-width="0px"
    :inline-message="true"
  >
    <el-table :data="formData" class="-mt-10px">
      <el-table-column label="序号" type="index" width="100" />
#foreach($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
        #set ($dictType = $column.dictType)
        #set ($javaField = $column.javaField)
        #set ($javaType = $column.javaType)
        #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment = $column.columnComment)
        #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
        #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
            #set ($dictMethod = "getIntDictOptions")
        #elseif ($javaType == "String")
            #set ($dictMethod = "getStrDictOptions")
        #elseif ($javaType == "Boolean")
            #set ($dictMethod = "getBoolDictOptions")
        #end
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-input v-model="row.${javaField}" placeholder="请输入${comment}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "imageUpload")## 图片上传
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <UploadImg v-model="row.${javaField}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "fileUpload")## 文件上传
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <UploadFile v-model="row.${javaField}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "editor")## 文本编辑器
      <el-table-column label="${comment}" min-width="400">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <Editor v-model="row.${javaField}" height="150px" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "select")## 下拉框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-select v-model="row.${javaField}" placeholder="请选择${comment}">
              #if ("" != $dictType)## 有数据字典
                <el-option
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              #else##没数据字典
                <el-option label="请选择字典生成" value="" />
              #end
            </el-select>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "checkbox")## 多选框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-checkbox-group v-model="row.${javaField}">
              #if ("" != $dictType)## 有数据字典
                <el-checkbox
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              #else##没数据字典
                <el-checkbox label="请选择字典生成" />
              #end
            </el-checkbox-group>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "radio")## 单选框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-radio-group v-model="row.${javaField}">
              #if ("" != $dictType)## 有数据字典
                <el-radio
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.value"
                >
                  {{ dict.label }}
                </el-radio>
              #else##没数据字典
                <el-radio value="1">请选择字典生成</el-radio>
              #end
            </el-radio-group>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "datetime")## 时间框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-date-picker
              v-model="row.${javaField}"
              type="date"
              value-format="x"
              placeholder="选择${comment}"
            />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "textarea")## 文本框
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-input v-model="row.${javaField}" type="textarea" placeholder="请输入${comment}" />
          </el-form-item>
        </template>
      </el-table-column>
        #end
    #end
#end
      <el-table-column align="center" fixed="right" label="操作" width="60">
        <template #default="{ $index }">
          <el-button @click="handleDelete($index)" link>—</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-form>
  <el-row justify="center" class="mt-3">
    <el-button @click="handleAdd" round>+ 添加${subTable.classComment}</el-button>
  </el-row>
#else## 情况二：一对一，form
  <el-form
    ref="formRef"
    :model="formData"
    :rules="formRules"
    label-width="100px"
    v-loading="formLoading"
  >
#foreach($column in $subColumns)
  #if ($column.createOperation || $column.updateOperation)
  #set ($dictType = $column.dictType)
      #set ($javaField = $column.javaField)
      #set ($javaType = $column.javaType)
      #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
      #set ($comment = $column.columnComment)
      #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
      #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
        #set ($dictMethod = "getIntDictOptions")
      #elseif ($javaType == "String")
          #set ($dictMethod = "getStrDictOptions")
      #elseif ($javaType == "Boolean")
          #set ($dictMethod = "getBoolDictOptions")
      #end
      #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
      #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
    <el-form-item label="${comment}" prop="${javaField}">
      <el-input v-model="formData.${javaField}" placeholder="请输入${comment}" />
    </el-form-item>
      #elseif($column.htmlType == "imageUpload")## 图片上传
    <el-form-item label="${comment}" prop="${javaField}">
      <UploadImg v-model="formData.${javaField}" />
    </el-form-item>
      #elseif($column.htmlType == "fileUpload")## 文件上传
    <el-form-item label="${comment}" prop="${javaField}">
      <UploadFile v-model="formData.${javaField}" />
    </el-form-item>
      #elseif($column.htmlType == "editor")## 文本编辑器
    <el-form-item label="${comment}" prop="${javaField}">
      <Editor v-model="formData.${javaField}" height="150px" />
    </el-form-item>
      #elseif($column.htmlType == "select")## 下拉框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-select v-model="formData.${javaField}" placeholder="请选择${comment}">
              #if ("" != $dictType)## 有数据字典
        <el-option
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.label"
          :value="dict.value"
        />
              #else##没数据字典
        <el-option label="请选择字典生成" value="" />
              #end
      </el-select>
    </el-form-item>
      #elseif($column.htmlType == "checkbox")## 多选框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-checkbox-group v-model="formData.${javaField}">
              #if ("" != $dictType)## 有数据字典
        <el-checkbox
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.label"
          :value="dict.value"
        />
              #else##没数据字典
        <el-checkbox label="请选择字典生成" />
              #end
      </el-checkbox-group>
    </el-form-item>
      #elseif($column.htmlType == "radio")## 单选框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-radio-group v-model="formData.${javaField}">
              #if ("" != $dictType)## 有数据字典
        <el-radio
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.value"
          >
          {{ dict.label }}
        </el-radio>
              #else##没数据字典
        <el-radio value="1">请选择字典生成</el-radio>
              #end
      </el-radio-group>
    </el-form-item>
      #elseif($column.htmlType == "datetime")## 时间框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-date-picker
        v-model="formData.${javaField}"
        type="date"
        value-format="x"
        placeholder="选择${comment}"
      />
    </el-form-item>
      #elseif($column.htmlType == "textarea")## 文本框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-input v-model="formData.${javaField}" type="textarea" placeholder="请输入${comment}" />
    </el-form-item>
      #end
  #end
#end
  </el-form>
#end
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'

const props = defineProps<{
  ${subJoinColumn.javaField}: undefined // ${subJoinColumn.columnComment}（主表的关联字段）
}>()
const formLoading = ref(false) // 表单的加载中
const formData = ref([])
const formRules = reactive({
#foreach ($column in $subColumns)
    #if (($column.createOperation || $column.updateOperation) && !$column.nullable && !${column.primaryKey})## 创建或者更新操作 && 要求非空 && 非主键
        #set($comment=$column.columnComment)
  $column.javaField: [{ required: true, message: \'${comment}不能为空\', trigger: #if($column.htmlType == \'select\')\'change\'#else\'blur\'#end }],
    #end
#end
})
const formRef = ref() // 表单 Ref

/** 监听主表的关联字段的变化，加载对应的子表数据 */
watch(
  () => props.${subJoinColumn.javaField},
  async (val) => {
    // 1. 重置表单
#if ( $subTable.subJoinMany )
    formData.value = []
#else
    formData.value = {
    #foreach ($column in $subColumns)
      #if ($column.createOperation || $column.updateOperation)
        #if ($column.htmlType == "checkbox")
      $column.javaField: [],
        #else
      $column.javaField: undefined,
        #end
      #end
    #end
    }
#end
    // 2. val 非空，则加载数据
    if (!val) {
      return;
    }
    try {
      formLoading.value = true
#if ( $subTable.subJoinMany )
      formData.value = await ${simpleClassName}Api.get${subSimpleClassName}ListBy${SubJoinColumnName}(val)
#else
      const data = await ${simpleClassName}Api.get${subSimpleClassName}By${SubJoinColumnName}(val)
      if (!data) {
        return
      }
      formData.value = data
#end
    } finally {
      formLoading.value = false
    }
  },
  { immediate: true }
)
#if ( $subTable.subJoinMany )

/** 新增按钮操作 */
const handleAdd = () => {
  const row = {
#foreach ($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
    $column.javaField: [],
      #else
    $column.javaField: undefined,
      #end
  #end
#end
  }
  row.${subJoinColumn.javaField} = props.${subJoinColumn.javaField}
  formData.value.push(row)
}

/** 删除按钮操作 */
const handleDelete = (index) => {
  formData.value.splice(index, 1)
}
#end

/** 表单校验 */
const validate = () => {
  return formRef.value.validate()
}

/** 表单值 */
const getData = () => {
  return formData.value
}

defineExpose({ validate, getData })
</script>
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (47, 3, 'vue3_ form_sub_normal.vue', 'vue3表单通用子表实现', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue3/views/components/form_sub_normal.vue.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($subSimpleClassName = $subSimpleClassNames.get($subIndex))
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
<template>
#if ( $subTable.subJoinMany )## 情况一：一对多，table + form
  <el-form
    ref="formRef"
    :model="formData"
    :rules="formRules"
    v-loading="formLoading"
    label-width="0px"
    :inline-message="true"
  >
    <el-table :data="formData" class="-mt-10px">
      <el-table-column label="序号" type="index" width="100" />
#foreach($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
        #set ($dictType = $column.dictType)
        #set ($javaField = $column.javaField)
        #set ($javaType = $column.javaType)
        #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment = $column.columnComment)
        #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
        #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
            #set ($dictMethod = "getIntDictOptions")
        #elseif ($javaType == "String")
            #set ($dictMethod = "getStrDictOptions")
        #elseif ($javaType == "Boolean")
            #set ($dictMethod = "getBoolDictOptions")
        #end
        #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
        #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-input v-model="row.${javaField}" placeholder="请输入${comment}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "imageUpload")## 图片上传
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <UploadImg v-model="row.${javaField}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "fileUpload")## 文件上传
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <UploadFile v-model="row.${javaField}" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "editor")## 文本编辑器
      <el-table-column label="${comment}" min-width="400">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <Editor v-model="row.${javaField}" height="150px" />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "select")## 下拉框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-select v-model="row.${javaField}" placeholder="请选择${comment}">
              #if ("" != $dictType)## 有数据字典
                <el-option
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              #else##没数据字典
                <el-option label="请选择字典生成" value="" />
              #end
            </el-select>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "checkbox")## 多选框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-checkbox-group v-model="row.${javaField}">
              #if ("" != $dictType)## 有数据字典
                <el-checkbox
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                />
              #else##没数据字典
                <el-checkbox label="请选择字典生成" />
              #end
            </el-checkbox-group>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "radio")## 单选框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-radio-group v-model="row.${javaField}">
              #if ("" != $dictType)## 有数据字典
                <el-radio
                  v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
                  :key="dict.value"
                  :label="dict.value"
                >
                  {{ dict.label }}
                </el-radio>
              #else##没数据字典
                <el-radio value="1">请选择字典生成</el-radio>
              #end
            </el-radio-group>
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "datetime")## 时间框
      <el-table-column label="${comment}" min-width="150">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-date-picker
              v-model="row.${javaField}"
              type="date"
              value-format="x"
              placeholder="选择${comment}"
            />
          </el-form-item>
        </template>
      </el-table-column>
        #elseif($column.htmlType == "textarea")## 文本框
      <el-table-column label="${comment}" min-width="200">
        <template #default="{ row, $index }">
          <el-form-item :prop="`${$index}.${javaField}`" :rules="formRules.${javaField}" class="mb-0px!">
            <el-input v-model="row.${javaField}" type="textarea" placeholder="请输入${comment}" />
          </el-form-item>
        </template>
      </el-table-column>
        #end
    #end
#end
      <el-table-column align="center" fixed="right" label="操作" width="60">
        <template #default="{ $index }">
          <el-button @click="handleDelete($index)" link>—</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-form>
  <el-row justify="center" class="mt-3">
    <el-button @click="handleAdd" round>+ 添加${subTable.classComment}</el-button>
  </el-row>
#else## 情况二：一对一，form
  <el-form
    ref="formRef"
    :model="formData"
    :rules="formRules"
    label-width="100px"
    v-loading="formLoading"
  >
#foreach($column in $subColumns)
  #if ($column.createOperation || $column.updateOperation)
  #set ($dictType = $column.dictType)
      #set ($javaField = $column.javaField)
      #set ($javaType = $column.javaType)
      #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
      #set ($comment = $column.columnComment)
      #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
      #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
        #set ($dictMethod = "getIntDictOptions")
      #elseif ($javaType == "String")
          #set ($dictMethod = "getStrDictOptions")
      #elseif ($javaType == "Boolean")
          #set ($dictMethod = "getBoolDictOptions")
      #end
      #if ( $column.id == $subJoinColumn.id) ## 特殊：忽略主子表的 join 字段，不用填写
      #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
    <el-form-item label="${comment}" prop="${javaField}">
      <el-input v-model="formData.${javaField}" placeholder="请输入${comment}" />
    </el-form-item>
      #elseif($column.htmlType == "imageUpload")## 图片上传
    <el-form-item label="${comment}" prop="${javaField}">
      <UploadImg v-model="formData.${javaField}" />
    </el-form-item>
      #elseif($column.htmlType == "fileUpload")## 文件上传
    <el-form-item label="${comment}" prop="${javaField}">
      <UploadFile v-model="formData.${javaField}" />
    </el-form-item>
      #elseif($column.htmlType == "editor")## 文本编辑器
    <el-form-item label="${comment}" prop="${javaField}">
      <Editor v-model="formData.${javaField}" height="150px" />
    </el-form-item>
      #elseif($column.htmlType == "select")## 下拉框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-select v-model="formData.${javaField}" placeholder="请选择${comment}">
              #if ("" != $dictType)## 有数据字典
        <el-option
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.label"
          :value="dict.value"
        />
              #else##没数据字典
        <el-option label="请选择字典生成" value="" />
              #end
      </el-select>
    </el-form-item>
      #elseif($column.htmlType == "checkbox")## 多选框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-checkbox-group v-model="formData.${javaField}">
              #if ("" != $dictType)## 有数据字典
        <el-checkbox
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.label"
          :value="dict.value"
        />
              #else##没数据字典
        <el-checkbox label="请选择字典生成" />
              #end
      </el-checkbox-group>
    </el-form-item>
      #elseif($column.htmlType == "radio")## 单选框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-radio-group v-model="formData.${javaField}">
              #if ("" != $dictType)## 有数据字典
        <el-radio
          v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
          :key="dict.value"
          :label="dict.value"
          >
          {{ dict.label }}
        </el-radio>
              #else##没数据字典
        <el-radio value="1">请选择字典生成</el-radio>
              #end
      </el-radio-group>
    </el-form-item>
      #elseif($column.htmlType == "datetime")## 时间框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-date-picker
        v-model="formData.${javaField}"
        type="date"
        value-format="x"
        placeholder="选择${comment}"
      />
    </el-form-item>
      #elseif($column.htmlType == "textarea")## 文本框
    <el-form-item label="${comment}" prop="${javaField}">
      <el-input v-model="formData.${javaField}" type="textarea" placeholder="请输入${comment}" />
    </el-form-item>
      #end
  #end
#end
  </el-form>
#end
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { ${simpleClassName}Api } from \'@/api/${table.moduleName}/${table.businessName}\'

const props = defineProps<{
  ${subJoinColumn.javaField}: undefined // ${subJoinColumn.columnComment}（主表的关联字段）
}>()
const formLoading = ref(false) // 表单的加载中
const formData = ref([])
const formRules = reactive({
#foreach ($column in $subColumns)
    #if (($column.createOperation || $column.updateOperation) && !$column.nullable && !${column.primaryKey})## 创建或者更新操作 && 要求非空 && 非主键
        #set($comment=$column.columnComment)
  $column.javaField: [{ required: true, message: \'${comment}不能为空\', trigger: #if($column.htmlType == \'select\')\'change\'#else\'blur\'#end }],
    #end
#end
})
const formRef = ref() // 表单 Ref

/** 监听主表的关联字段的变化，加载对应的子表数据 */
watch(
  () => props.${subJoinColumn.javaField},
  async (val) => {
    // 1. 重置表单
#if ( $subTable.subJoinMany )
    formData.value = []
#else
    formData.value = {
    #foreach ($column in $subColumns)
      #if ($column.createOperation || $column.updateOperation)
        #if ($column.htmlType == "checkbox")
      $column.javaField: [],
        #else
      $column.javaField: undefined,
        #end
      #end
    #end
    }
#end
    // 2. val 非空，则加载数据
    if (!val) {
      return;
    }
    try {
      formLoading.value = true
#if ( $subTable.subJoinMany )
      formData.value = await ${simpleClassName}Api.get${subSimpleClassName}ListBy${SubJoinColumnName}(val)
#else
      const data = await ${simpleClassName}Api.get${subSimpleClassName}By${SubJoinColumnName}(val)
      if (!data) {
        return
      }
      formData.value = data
#end
    } finally {
      formLoading.value = false
    }
  },
  { immediate: true }
)
#if ( $subTable.subJoinMany )

/** 新增按钮操作 */
const handleAdd = () => {
  const row = {
#foreach ($column in $subColumns)
    #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
    $column.javaField: [],
      #else
    $column.javaField: undefined,
      #end
  #end
#end
  }
  row.${subJoinColumn.javaField} = props.${subJoinColumn.javaField}
  formData.value.push(row)
}

/** 删除按钮操作 */
const handleDelete = (index) => {
  formData.value.splice(index, 1)
}
#end

/** 表单校验 */
const validate = () => {
  return formRef.value.validate()
}

/** 表单值 */
const getData = () => {
  return formData.value
}

defineExpose({ validate, getData })
</script>
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (48, 3, 'vue3_form', 'vue3的前端弹出表单，用于新增修改', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/${simpleClassName}Form.vue', 'codegen/vue3/views/form.vue.vm', '<template>
  <Dialog :title="dialogTitle" v-model="dialogVisible">
    <el-form
      ref="formRef"
      :model="formData"
      :rules="formRules"
      label-width="100px"
      v-loading="formLoading"
    >
#foreach($column in $columns)
    #if ($column.createOperation || $column.updateOperation)
        #set ($dictType = $column.dictType)
        #set ($javaField = $column.javaField)
        #set ($javaType = $column.javaType)
        #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment = $column.columnComment)
        #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
        #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
            #set ($dictMethod = "getIntDictOptions")
        #elseif ($javaType == "String")
            #set ($dictMethod = "getStrDictOptions")
        #elseif ($javaType == "Boolean")
            #set ($dictMethod = "getBoolDictOptions")
        #end
        #if ( $table.templateType == 2 && $column.id == $treeParentColumn.id )
      <el-form-item label="${comment}" prop="${javaField}">
        <el-tree-select
          v-model="formData.${javaField}"
          :data="${classNameVar}Tree"
          #if ($treeNameColumn.javaField == "name")
          :props="defaultProps"
          #else
          :props="{...defaultProps, label: \'$treeNameColumn.javaField\'}"
          #end
          check-strictly
          default-expand-all
          placeholder="请选择${comment}"
        />
      </el-form-item>
        #elseif ($column.htmlType == "input" && !$column.primaryKey)## 忽略主键，不用在表单里
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input v-model="formData.${javaField}" placeholder="请输入${comment}" />
      </el-form-item>
        #elseif($column.htmlType == "imageUpload")## 图片上传
      <el-form-item label="${comment}" prop="${javaField}">
        <UploadImg v-model="formData.${javaField}" />
      </el-form-item>
        #elseif($column.htmlType == "fileUpload")## 文件上传
      <el-form-item label="${comment}" prop="${javaField}">
        <UploadFile v-model="formData.${javaField}" />
      </el-form-item>
        #elseif($column.htmlType == "editor")## 文本编辑器
      <el-form-item label="${comment}" prop="${javaField}">
        <Editor v-model="formData.${javaField}" height="150px" />
      </el-form-item>
        #elseif($column.htmlType == "select")## 下拉框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-select v-model="formData.${javaField}" placeholder="请选择${comment}">
                #if ("" != $dictType)## 有数据字典
          <el-option
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else##没数据字典
          <el-option label="请选择字典生成" value="" />
                #end
        </el-select>
      </el-form-item>
        #elseif($column.htmlType == "checkbox")## 多选框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-checkbox-group v-model="formData.${javaField}">
                #if ("" != $dictType)## 有数据字典
          <el-checkbox
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else##没数据字典
          <el-checkbox label="请选择字典生成" />
                #end
        </el-checkbox-group>
      </el-form-item>
        #elseif($column.htmlType == "radio")## 单选框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-radio-group v-model="formData.${javaField}">
                #if ("" != $dictType)## 有数据字典
          <el-radio
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.value"
          >
            {{ dict.label }}
          </el-radio>
                #else##没数据字典
          <el-radio value="1">请选择字典生成</el-radio>
                #end
        </el-radio-group>
      </el-form-item>
        #elseif($column.htmlType == "datetime")## 时间框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-date-picker
          v-model="formData.${javaField}"
          type="date"
          value-format="x"
          placeholder="选择${comment}"
        />
      </el-form-item>
        #elseif($column.htmlType == "textarea")## 文本框
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input v-model="formData.${javaField}" type="textarea" placeholder="请输入${comment}" />
      </el-form-item>
        #end
    #end
#end
    </el-form>
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
    <!-- 子表的表单 -->
    <el-tabs v-model="subTabsName">
    #foreach ($subTable in $subTables)
      #set ($index = $foreach.count - 1)
      #set ($subClassNameVar = $subClassNameVars.get($index))
      #set ($subSimpleClassName = $subSimpleClassNames.get($index))
      #set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
      <el-tab-pane label="${subTable.classComment}" name="$subClassNameVar">
        <${subSimpleClassName}Form ref="${subClassNameVar}FormRef" :${subJoinColumn_strikeCase}="formData.id" />
      </el-tab-pane>
    #end
    </el-tabs>
#end
    <template #footer>
      <el-button @click="submitForm" type="primary" :disabled="formLoading">确 定</el-button>
      <el-button @click="dialogVisible = false">取 消</el-button>
    </template>
  </Dialog>
</template>
<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { ${simpleClassName}Api, ${simpleClassName}VO } from \'@/api/${table.moduleName}/${table.businessName}\'
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
import { defaultProps, handleTree } from \'@/utils/tree\'
#end
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
#foreach ($subSimpleClassName in $subSimpleClassNames)
import ${subSimpleClassName}Form from \'./components/${subSimpleClassName}Form.vue\'
#end
#end

/** ${table.classComment} 表单 */
defineOptions({ name: \'${simpleClassName}Form\' })

const { t } = useI18n() // 国际化
const message = useMessage() // 消息弹窗

const dialogVisible = ref(false) // 弹窗的是否展示
const dialogTitle = ref(\'\') // 弹窗的标题
const formLoading = ref(false) // 表单的加载中：1）修改时的数据加载；2）提交的按钮禁用
const formType = ref(\'\') // 表单的类型：create - 新增；update - 修改
const formData = ref({
#foreach ($column in $columns)
    #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
  $column.javaField: [],
      #else
  $column.javaField: undefined,
      #end
    #end
#end
})
const formRules = reactive({
#foreach ($column in $columns)
    #if (($column.createOperation || $column.updateOperation) && !$column.nullable && !${column.primaryKey})## 创建或者更新操作 && 要求非空 && 非主键
        #set($comment=$column.columnComment)
  $column.javaField: [{ required: true, message: \'${comment}不能为空\', trigger: #if($column.htmlType == \'select\')\'change\'#else\'blur\'#end }],
    #end
#end
})
const formRef = ref() // 表单 Ref
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
const ${classNameVar}Tree = ref() // 树形结构
#end
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
#if ( $subTables && $subTables.size() > 0 )

/** 子表的表单 */
const subTabsName = ref(\'$subClassNameVars.get(0)\')
#foreach ($subClassNameVar in $subClassNameVars)
const ${subClassNameVar}FormRef = ref()
#end
#end
#end

/** 打开弹窗 */
const open = async (type: string, id?: number) => {
  dialogVisible.value = true
  dialogTitle.value = t(\'action.\' + type)
  formType.value = type
  resetForm()
  // 修改时，设置数据
  if (id) {
    formLoading.value = true
    try {
      formData.value = await ${simpleClassName}Api.get${simpleClassName}(id)
    } finally {
      formLoading.value = false
    }
  }
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
  await get${simpleClassName}Tree()
#end
}
defineExpose({ open }) // 提供 open 方法，用于打开弹窗

/** 提交表单 */
const emit = defineEmits([\'success\']) // 定义 success 事件，用于操作成功后的回调
const submitForm = async () => {
  // 校验表单
  await formRef.value.validate()
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
#if ( $subTables && $subTables.size() > 0 )
  // 校验子表单
  #foreach ($subTable in $subTables)
  #set ($index = $foreach.count - 1)
  #set ($subClassNameVar = $subClassNameVars.get($index))
  try {
    await ${subClassNameVar}FormRef.value.validate()
  } catch (e) {
    subTabsName.value = \'${subClassNameVar}\'
    return
  }
  #end
#end
#end
  // 提交请求
  formLoading.value = true
  try {
    const data = formData.value as unknown as ${simpleClassName}VO
## 特殊：主子表专属逻辑
#if ( $table.templateType == 10 || $table.templateType == 12 )
#if ( $subTables && $subTables.size() > 0 )
    // 拼接子表的数据
  #foreach ($subTable in $subTables)
  #set ($index = $foreach.count - 1)
  #set ($subClassNameVar = $subClassNameVars.get($index))
    data.${subClassNameVar}#if ( $subTable.subJoinMany)s#end = ${subClassNameVar}FormRef.value.getData()
  #end
#end
#end
    if (formType.value === \'create\') {
      await ${simpleClassName}Api.create${simpleClassName}(data)
      message.success(t(\'common.createSuccess\'))
    } else {
      await ${simpleClassName}Api.update${simpleClassName}(data)
      message.success(t(\'common.updateSuccess\'))
    }
    dialogVisible.value = false
    // 发送操作成功的事件
    emit(\'success\')
  } finally {
    formLoading.value = false
  }
}

/** 重置表单 */
const resetForm = () => {
  formData.value = {
#foreach ($column in $columns)
  #if ($column.createOperation || $column.updateOperation)
      #if ($column.htmlType == "checkbox")
    $column.javaField: [],
      #else
    $column.javaField: undefined,
      #end
  #end
#end
  }
  formRef.value?.resetFields()
}
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )

/** 获得${table.classComment}树 */
const get${simpleClassName}Tree = async () => {
  ${classNameVar}Tree.value = []
  const data = await ${simpleClassName}Api.get${simpleClassName}List()
  const root: Tree = { id: 0, name: \'顶级${table.classComment}\', children: [] }
  root.children = handleTree(data, \'id\', \'${treeParentColumn.javaField}\')
  ${classNameVar}Tree.value.push(root)
}
#end
</script>
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (49, 3, 'vue3_index', 'vue3前端index', 'FRONT', 'VUE3', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue3/src/views/${table.moduleName}/${table.businessName}/index.vue', 'codegen/vue3/views/index.vue.vm', '<template>
  <ContentWrap>
    <!-- 搜索工作栏 -->
    <el-form
      class="-mb-15px"
      :model="queryParams"
      ref="queryFormRef"
      :inline="true"
      label-width="68px"
    >
    #foreach($column in $columns)
        #if ($column.listOperation)
            #set ($dictType = $column.dictType)
            #set ($javaField = $column.javaField)
            #set ($javaType = $column.javaType)
            #set ($AttrName = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
            #set ($comment = $column.columnComment)
            #set ($dictMethod = "getDictOptions")## 计算使用哪个 dict 字典方法
            #if ($javaType == "Integer" || $javaType == "Long" || $javaType == "Byte" || $javaType == "Short")
                #set ($dictMethod = "getIntDictOptions")
            #elseif ($javaType == "String")
                #set ($dictMethod = "getStrDictOptions")
            #elseif ($javaType == "Boolean")
                #set ($dictMethod = "getBoolDictOptions")
            #end
            #if ($column.htmlType == "input")
      <el-form-item label="${comment}" prop="${javaField}">
        <el-input
          v-model="queryParams.${javaField}"
          placeholder="请输入${comment}"
          clearable
          @keyup.enter="handleQuery"
          class="!w-240px"
        />
      </el-form-item>
            #elseif ($column.htmlType == "select" || $column.htmlType == "radio")
      <el-form-item label="${comment}" prop="${javaField}">
        <el-select
          v-model="queryParams.${javaField}"
          placeholder="请选择${comment}"
          clearable
          class="!w-240px"
        >
                #if ("" != $dictType)## 设置了 dictType 数据字典的情况
          <el-option
            v-for="dict in $dictMethod(DICT_TYPE.$dictType.toUpperCase())"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
                #else## 未设置 dictType 数据字典的情况
          <el-option label="请选择字典生成" value="" />
                #end
        </el-select>
      </el-form-item>
    #elseif($column.htmlType == "datetime")
      #if ($column.listOperationCondition != "BETWEEN")## 非范围
      <el-form-item label="${comment}" prop="${javaField}">
        <el-date-picker
          v-model="queryParams.${javaField}"
          value-format="YYYY-MM-DD"
          type="date"
          placeholder="选择${comment}"
          clearable
          class="!w-240px"
        />
      </el-form-item>
      #else## 范围
      <el-form-item label="${comment}" prop="${javaField}">
        <el-date-picker
          v-model="queryParams.${javaField}"
          value-format="YYYY-MM-DD HH:mm:ss"
          type="daterange"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          :default-time="[new Date(\'1 00:00:00\'), new Date(\'1 23:59:59\')]"
          class="!w-220px"
        />
      </el-form-item>
      #end
    #end
    #end
    #end
      <el-form-item>
        <el-button @click="handleQuery"><Icon icon="ep:search" class="mr-5px" /> 搜索</el-button>
        <el-button @click="resetQuery"><Icon icon="ep:refresh" class="mr-5px" /> 重置</el-button>
        <el-button
          type="primary"
          plain
          @click="openForm(\'create\')"
          v-hasPermi="[\'${permissionPrefix}:create\']"
        >
          <Icon icon="ep:plus" class="mr-5px" /> 新增
        </el-button>
        <el-button
          type="success"
          plain
          @click="handleExport"
          :loading="exportLoading"
          v-hasPermi="[\'${permissionPrefix}:export\']"
        >
          <Icon icon="ep:download" class="mr-5px" /> 导出
        </el-button>
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
        <el-button type="danger" plain @click="toggleExpandAll">
          <Icon icon="ep:sort" class="mr-5px" /> 展开/折叠
        </el-button>
#end
      </el-form-item>
    </el-form>
  </ContentWrap>

  <!-- 列表 -->
  <ContentWrap>
## 特殊：主子表专属逻辑
#if ( $table.templateType == 11 && $subTables && $subTables.size() > 0 )
    <el-table
      v-loading="loading"
      :data="list"
      :stripe="true"
      :show-overflow-tooltip="true"
      highlight-current-row
      @current-change="handleCurrentChange"
    >
## 特殊：树表专属逻辑
#elseif ( $table.templateType == 2 )
    <el-table
      v-loading="loading"
      :data="list"
      :stripe="true"
      :show-overflow-tooltip="true"
      row-key="id"
      :default-expand-all="isExpandAll"
      v-if="refreshTable"
    >
#else
    <el-table v-loading="loading" :data="list" :stripe="true" :show-overflow-tooltip="true">
#end
## 特殊：主子表专属逻辑
#if ( $table.templateType == 12 && $subTables && $subTables.size() > 0 )
      <!-- 子表的列表 -->
      <el-table-column type="expand">
        <template #default="scope">
          <el-tabs model-value="$subClassNameVars.get(0)">
            #foreach ($subTable in $subTables)
              #set ($index = $foreach.count - 1)
              #set ($subClassNameVar = $subClassNameVars.get($index))
              #set ($subSimpleClassName = $subSimpleClassNames.get($index))
              #set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
            <el-tab-pane label="${subTable.classComment}" name="$subClassNameVar">
              <${subSimpleClassName}List :${subJoinColumn_strikeCase}="scope.row.id" />
            </el-tab-pane>
            #end
          </el-tabs>
        </template>
      </el-table-column>
#end
      #foreach($column in $columns)
      #if ($column.listOperationResult)
        #set ($dictType=$column.dictType)
        #set ($javaField = $column.javaField)
        #set ($AttrName=$column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})
        #set ($comment=$column.columnComment)
        #if ($column.javaType == "LocalDateTime")## 时间类型
      <el-table-column
        label="${comment}"
        align="center"
        prop="${javaField}"
        :formatter="dateFormatter"
        width="180px"
      />
        #elseif($column.dictType && "" != $column.dictType)## 数据字典
      <el-table-column label="${comment}" align="center" prop="${javaField}">
        <template #default="scope">
          <dict-tag :type="DICT_TYPE.$dictType.toUpperCase()" :value="scope.row.${column.javaField}" />
        </template>
      </el-table-column>
        #else
      <el-table-column label="${comment}" align="center" prop="${javaField}" />
        #end
      #end
    #end
      <el-table-column label="操作" align="center" min-width="120px">
        <template #default="scope">
          <el-button
            link
            type="primary"
            @click="openForm(\'update\', scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:update\']"
          >
            编辑
          </el-button>
          <el-button
            link
            type="danger"
            @click="handleDelete(scope.row.id)"
            v-hasPermi="[\'${permissionPrefix}:delete\']"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页 -->
    <Pagination
      :total="total"
      v-model:page="queryParams.pageNo"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />
  </ContentWrap>

  <!-- 表单弹窗：添加/修改 -->
  <${simpleClassName}Form ref="formRef" @success="getList" />
## 特殊：主子表专属逻辑
#if ( $table.templateType == 11 && $subTables && $subTables.size() > 0 )
  <!-- 子表的列表 -->
  <ContentWrap>
    <el-tabs model-value="$subClassNameVars.get(0)">
      #foreach ($subTable in $subTables)
        #set ($index = $foreach.count - 1)
        #set ($subClassNameVar = $subClassNameVars.get($index))
        #set ($subSimpleClassName = $subSimpleClassNames.get($index))
        #set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
      <el-tab-pane label="${subTable.classComment}" name="$subClassNameVar">
        <${subSimpleClassName}List :${subJoinColumn_strikeCase}="currentRow.id" />
      </el-tab-pane>
      #end
    </el-tabs>
  </ContentWrap>
#end
</template>

<script setup lang="ts">
import { getIntDictOptions, getStrDictOptions, getBoolDictOptions, DICT_TYPE } from \'@/utils/dict\'
import { dateFormatter } from \'@/utils/formatTime\'
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
import { handleTree } from \'@/utils/tree\'
#end
import download from \'@/utils/download\'
import { ${simpleClassName}Api, ${simpleClassName}VO } from \'@/api/${table.moduleName}/${table.businessName}\'
import ${simpleClassName}Form from \'./${simpleClassName}Form.vue\'
## 特殊：主子表专属逻辑
#if ( $table.templateType != 10 )
#foreach ($subSimpleClassName in $subSimpleClassNames)
import ${subSimpleClassName}List from \'./components/${subSimpleClassName}List.vue\'
#end
#end

/** ${table.classComment} 列表 */
defineOptions({ name: \'${table.className}\' })

const message = useMessage() // 消息弹窗
const { t } = useI18n() // 国际化

const loading = ref(true) // 列表的加载中
const list = ref<${simpleClassName}VO[]>([]) // 列表的数据
## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
const total = ref(0) // 列表的总页数
#end
const queryParams = reactive({
## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
  pageNo: 1,
  pageSize: 10,
#end
  #foreach ($column in $columns)
    #if ($column.listOperation)
      #if ($column.listOperationCondition != \'BETWEEN\')
  $column.javaField: undefined,
  #end
      #if ($column.htmlType == "datetime" || $column.listOperationCondition == "BETWEEN")
  $column.javaField: [],
      #end
    #end
  #end
})
const queryFormRef = ref() // 搜索的表单
const exportLoading = ref(false) // 导出的加载中

/** 查询列表 */
const getList = async () => {
  loading.value = true
  try {
## 特殊：树表专属逻辑（树不需要分页接口）
  #if ( $table.templateType == 2 )
    const data = await ${simpleClassName}Api.get${simpleClassName}List(queryParams)
    list.value = handleTree(data, \'id\', \'${treeParentColumn.javaField}\')
  #else
    const data = await ${simpleClassName}Api.get${simpleClassName}Page(queryParams)
    list.value = data.list
    total.value = data.total
  #end
  } finally {
    loading.value = false
  }
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.pageNo = 1
  getList()
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryFormRef.value.resetFields()
  handleQuery()
}

/** 添加/修改操作 */
const formRef = ref()
const openForm = (type: string, id?: number) => {
  formRef.value.open(type, id)
}

/** 删除按钮操作 */
const handleDelete = async (id: number) => {
  try {
    // 删除的二次确认
    await message.delConfirm()
    // 发起删除
    await ${simpleClassName}Api.delete${simpleClassName}(id)
    message.success(t(\'common.delSuccess\'))
    // 刷新列表
    await getList()
  } catch {}
}

/** 导出按钮操作 */
const handleExport = async () => {
  try {
    // 导出的二次确认
    await message.exportConfirm()
    // 发起导出
    exportLoading.value = true
    const data = await ${simpleClassName}Api.export${simpleClassName}(queryParams)
    download.excel(data, \'${table.classComment}.xls\')
  } catch {
  } finally {
    exportLoading.value = false
  }
}
## 特殊：主子表专属逻辑
#if ( $table.templateType == 11 )

/** 选中行操作 */
const currentRow = ref({}) // 选中行
const handleCurrentChange = (row) => {
  currentRow.value = row
}
#end
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )

/** 展开/折叠操作 */
const isExpandAll = ref(true) // 是否展开，默认全部展开
const refreshTable = ref(true) // 重新渲染表格状态
const toggleExpandAll = async () => {
  refreshTable.value = false
  isExpandAll.value = !isExpandAll.value
  await nextTick()
  refreshTable.value = true
}
#end

/** 初始化 **/
onMounted(() => {
  getList()
})
</script>
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (50, 3, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}List.vue', 'codegen/vue/views/components/list_sub_erp.vue.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (51, 3, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}List.vue', 'codegen/vue/views/components/list_sub_inner.vue.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (52, 3, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue/views/components/form_sub_erp.vue.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (53, 3, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue/views/components/form_sub_inner.vue.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (54, 3, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/components/${subSimpleClassNames[subIndex]}Form.vue', 'codegen/vue/views/components/form_sub_normal.vue.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (55, 3, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/${simpleClassName}Form.vue', 'codegen/vue/views/form.vue.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (56, 3, '', '', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/api/${table.moduleName}/${table.businessName}/index.js', 'codegen/vue/api/api.js.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (57, 3, 'vue2_index.vue.vm', 'vue2_index.vue.vm', 'FRONT', 'VUE2', 'java', 'yudao-ui-${sceneEnum.basePackage}-vue2/src/views/${table.moduleName}/${table.businessName}/index.vue', 'codegen/vue/views/index.vue.vm', '', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (58, 3, 'h2_sql', 'h2类型数据库sql', 'SERVER', 'SERVER', 'java', 'sql/h2.sql', 'codegen/sql/h2.vm', '-- 将该建表 SQL 语句，添加到 yudao-module-${table.moduleName}-biz 模块的 test/resources/sql/create_tables.sql 文件里
CREATE TABLE IF NOT EXISTS "${table.tableName.toLowerCase()}" (
#foreach ($column in $columns)
#if (${column.javaType} == \'Long\')
    #set ($dataType=\'bigint\')
#elseif (${column.javaType} == \'Integer\')
    #set ($dataType=\'int\')
#elseif (${column.javaType} == \'Boolean\')
    #set ($dataType=\'bit\')
#elseif (${column.javaType} == \'Date\')
    #set ($dataType=\'datetime\')
#else
    #set ($dataType=\'varchar\')
#end
    #if (${column.primaryKey})##处理主键
    "${column.javaField}"#if (${column.javaType} == \'String\') ${dataType} NOT NULL#else ${dataType} NOT NULL GENERATED BY DEFAULT AS IDENTITY#end,
    #else
    #if (${column.columnName} == \'create_time\')
    "create_time" datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    #elseif (${column.columnName} == \'update_time\')
    "update_time" datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    #elseif (${column.columnName} == \'creator\' || ${column.columnName} == \'updater\')
    "${column.columnName}" ${dataType} DEFAULT \'\',
    #elseif (${column.columnName} == \'deleted\')
    "deleted" bit NOT NULL DEFAULT FALSE,
    #elseif (${column.columnName} == \'tenant_id\')
    "tenant_id" bigint NOT NULL DEFAULT 0,
    #else
    "${column.columnName.toLowerCase()}" ${dataType}#if (${column.nullable} == false) NOT NULL#end,
    #end
    #end
#end
    PRIMARY KEY ("${primaryColumn.columnName.toLowerCase()}")
) COMMENT \'${table.tableComment}\';

-- 将该删表 SQL 语句，添加到 yudao-module-${table.moduleName}-biz 模块的 test/resources/sql/clean.sql 文件里
DELETE FROM "${table.tableName}";
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (59, 3, 'menu_sql', '菜单的执行sql', 'SERVER', 'SERVER', 'java', 'sql/sql.sql', 'codegen/sql/sql.vm', '-- 菜单 SQL
INSERT INTO system_menu(
    name, permission, type, sort, parent_id,
    path, icon, component, status, component_name
)
VALUES (
    \'${table.classComment}管理\', \'\', 2, 0, ${table.parentMenuId},
    \'${simpleClassName_strikeCase}\', \'\', \'${table.moduleName}/${table.businessName}/index\', 0, \'${table.className}\'
);

-- 按钮父菜单ID
-- 暂时只支持 MySQL。如果你是 Oracle、PostgreSQL、SQLServer 的话，需要手动修改 @parentId 的部分的代码
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
#set ($functionNames = [\'查询\', \'创建\', \'更新\', \'删除\', \'导出\'])
#set ($functionOps = [\'query\', \'create\', \'update\', \'delete\', \'export\'])
#foreach ($functionName in $functionNames)
#set ($index = $foreach.count - 1)
INSERT INTO system_menu(
    name, permission, type, sort, parent_id,
    path, icon, component, status
)
VALUES (
    \'${table.classComment}${functionName}\', \'${permissionPrefix}:${functionOps.get($index)}\', 3, $foreach.count, @parentId,
    \'\', \'\', \'\', 0
);
#end
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (60, 3, 'errorcode', '异常code', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-api/src/main/java/${basePackageFilePath}/module/${table.moduleName}/enums/ErrorCodeConstants_手动操作.java', 'codegen/java/enums/errorcode.vm', '// TODO 待办：请将下面的错误码复制到 yudao-module-${table.moduleName}-api 模块的 ErrorCodeConstants 类中。注意，请给“TODO 补充编号”设置一个错误码编号！！！
// ========== ${table.classComment} TODO 补充编号 ==========
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_NOT_EXISTS = new ErrorCode(TODO 补充编号, "${table.classComment}不存在");
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_EXITS_CHILDREN = new ErrorCode(TODO 补充编号, "存在存在子${table.classComment}，无法删除");
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_PARENT_NOT_EXITS = new ErrorCode(TODO 补充编号,"父级${table.classComment}不存在");
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_PARENT_ERROR = new ErrorCode(TODO 补充编号, "不能设置自己为父${table.classComment}");
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_${treeNameColumn_javaField_underlineCase.toUpperCase()}_DUPLICATE = new ErrorCode(TODO 补充编号, "已经存在该${treeNameColumn.columnComment}的${table.classComment}");
ErrorCode ${simpleClassName_underlineCase.toUpperCase()}_PARENT_IS_CHILD = new ErrorCode(TODO 补充编号, "不能设置自己的子${table.className}为父${table.className}");
#end
## 特殊：主子表专属逻辑
#if ( $table.templateType == 11 )## 特殊：ERP 情况
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($simpleClassNameUnderlineCase = $simpleClassNameUnderlineCases.get($index))
ErrorCode ${simpleClassNameUnderlineCase.toUpperCase()}_NOT_EXISTS = new ErrorCode(TODO 补充编号, "${subTable.classComment}不存在");
#if ( !$subTable.subJoinMany )
ErrorCode ${simpleClassNameUnderlineCase.toUpperCase()}_EXISTS = new ErrorCode(TODO 补充编号, "${subTable.classComment}已存在");
#end
#end
#end
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (61, 3, 'serviceTest', 'service单测', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/test/java/${basePackageFilePath}/module/${table.moduleName}/service/${table.businessName}/${table.className}ServiceImplTest.java', 'codegen/java/test/serviceTest.vm', 'package ${basePackage}.module.${table.moduleName}.service.${table.businessName};

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.mock.mockito.MockBean;

import ${jakartaPackage}.annotation.Resource;

import ${baseFrameworkPackage}.test.core.ut.BaseDbUnitTest;

import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
import ${basePackage}.module.${table.moduleName}.dal.mysql.${table.businessName}.${table.className}Mapper;
import ${PageResultClassName};

import ${jakartaPackage}.annotation.Resource;
import org.springframework.context.annotation.Import;
import java.util.*;
import java.time.LocalDateTime;

import static cn.hutool.core.util.RandomUtil.*;
import static ${basePackage}.module.${table.moduleName}.enums.ErrorCodeConstants.*;
import static ${baseFrameworkPackage}.test.core.util.AssertUtils.*;
import static ${baseFrameworkPackage}.test.core.util.RandomUtils.*;
import static ${LocalDateTimeUtilsClassName}.*;
import static ${ObjectUtilsClassName}.*;
import static ${DateUtilsClassName}.*;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

## 字段模板
#macro(getPageCondition $VO)
       // mock 数据
       ${table.className}DO db${simpleClassName} = randomPojo(${table.className}DO.class, o -> { // 等会查询到
       #foreach ($column in $columns)
       #if (${column.listOperation})
       #set ($JavaField = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})##首字母大写
           o.set$JavaField(null);
       #end
       #end
       });
       ${classNameVar}Mapper.insert(db${simpleClassName});
       #foreach ($column in $columns)
       #if (${column.listOperation})
       #set ($JavaField = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})##首字母大写
       // 测试 ${column.javaField} 不匹配
       ${classNameVar}Mapper.insert(cloneIgnoreId(db${simpleClassName}, o -> o.set$JavaField(null)));
       #end
       #end
       // 准备参数
       ${sceneEnum.prefixClass}${table.className}${VO} reqVO = new ${sceneEnum.prefixClass}${table.className}${VO}();
       #foreach ($column in $columns)
       #if (${column.listOperation})
       #set ($JavaField = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})##首字母大写
       #if (${column.listOperationCondition} == "BETWEEN")## BETWEEN 的情况
       reqVO.set${JavaField}(buildBetweenTime(2023, 2, 1, 2023, 2, 28));
       #else
       reqVO.set$JavaField(null);
       #end
       #end
       #end
#end
/**
 * {@link ${table.className}ServiceImpl} 的单元测试类
 *
 * @author ${table.author}
 */
@Import(${table.className}ServiceImpl.class)
public class ${table.className}ServiceImplTest extends BaseDbUnitTest {

    @Resource
    private ${table.className}ServiceImpl ${classNameVar}Service;

    @Resource
    private ${table.className}Mapper ${classNameVar}Mapper;

    @Test
    public void testCreate${simpleClassName}_success() {
        // 准备参数
        ${sceneEnum.prefixClass}${table.className}SaveReqVO createReqVO = randomPojo(${sceneEnum.prefixClass}${table.className}SaveReqVO.class).setId(null);

        // 调用
        ${primaryColumn.javaType} ${classNameVar}Id = ${classNameVar}Service.create${simpleClassName}(createReqVO);
        // 断言
        assertNotNull(${classNameVar}Id);
        // 校验记录的属性是否正确
        ${table.className}DO ${classNameVar} = ${classNameVar}Mapper.selectById(${classNameVar}Id);
        assertPojoEquals(createReqVO, ${classNameVar}, "id");
    }

    @Test
    public void testUpdate${simpleClassName}_success() {
        // mock 数据
        ${table.className}DO db${simpleClassName} = randomPojo(${table.className}DO.class);
        ${classNameVar}Mapper.insert(db${simpleClassName});// @Sql: 先插入出一条存在的数据
        // 准备参数
        ${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO = randomPojo(${sceneEnum.prefixClass}${table.className}SaveReqVO.class, o -> {
            o.setId(db${simpleClassName}.getId()); // 设置更新的 ID
        });

        // 调用
        ${classNameVar}Service.update${simpleClassName}(updateReqVO);
        // 校验是否更新正确
        ${table.className}DO ${classNameVar} = ${classNameVar}Mapper.selectById(updateReqVO.getId()); // 获取最新的
        assertPojoEquals(updateReqVO, ${classNameVar});
    }

    @Test
    public void testUpdate${simpleClassName}_notExists() {
        // 准备参数
        ${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO = randomPojo(${sceneEnum.prefixClass}${table.className}SaveReqVO.class);

        // 调用, 并断言异常
        assertServiceException(() -> ${classNameVar}Service.update${simpleClassName}(updateReqVO), ${simpleClassName_underlineCase.toUpperCase()}_NOT_EXISTS);
    }

    @Test
    public void testDelete${simpleClassName}_success() {
        // mock 数据
        ${table.className}DO db${simpleClassName} = randomPojo(${table.className}DO.class);
        ${classNameVar}Mapper.insert(db${simpleClassName});// @Sql: 先插入出一条存在的数据
        // 准备参数
        ${primaryColumn.javaType} id = db${simpleClassName}.getId();

        // 调用
        ${classNameVar}Service.delete${simpleClassName}(id);
       // 校验数据不存在了
       assertNull(${classNameVar}Mapper.selectById(id));
    }

    @Test
    public void testDelete${simpleClassName}_notExists() {
        // 准备参数
        ${primaryColumn.javaType} id = random${primaryColumn.javaType}Id();

        // 调用, 并断言异常
        assertServiceException(() -> ${classNameVar}Service.delete${simpleClassName}(id), ${simpleClassName_underlineCase.toUpperCase()}_NOT_EXISTS);
    }

## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
    @Test
    @Disabled  // TODO 请修改 null 为需要的值，然后删除 @Disabled 注解
    public void testGet${simpleClassName}Page() {
       #getPageCondition("PageReqVO")

       // 调用
       PageResult<${table.className}DO> pageResult = ${classNameVar}Service.get${simpleClassName}Page(reqVO);
       // 断言
       assertEquals(1, pageResult.getTotal());
       assertEquals(1, pageResult.getList().size());
       assertPojoEquals(db${simpleClassName}, pageResult.getList().get(0));
    }
#else
    @Test
    @Disabled  // TODO 请修改 null 为需要的值，然后删除 @Disabled 注解
    public void testGet${simpleClassName}List() {
       #getPageCondition("ListReqVO")

       // 调用
       List<${table.className}DO> list = ${classNameVar}Service.get${simpleClassName}List(reqVO);
       // 断言
       assertEquals(1, list.size());
       assertPojoEquals(db${simpleClassName}, list.get(0));
    }
#end

}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (62, 3, 'service', 'service接口类', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/service/${table.businessName}/${table.className}Service.java', 'codegen/java/service/service.vm', 'package ${basePackage}.module.${table.moduleName}.service.${table.businessName};

import java.util.*;
import ${jakartaPackage}.validation.*;
import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
#end
import ${PageResultClassName};
import ${PageParamClassName};

/**
 * ${table.classComment} Service 接口
 *
 * @author ${table.author}
 */
public interface ${table.className}Service {

    /**
     * 创建${table.classComment}
     *
     * @param createReqVO 创建信息
     * @return 编号
     */
    ${primaryColumn.javaType} create${simpleClassName}(@Valid ${sceneEnum.prefixClass}${table.className}SaveReqVO createReqVO);

    /**
     * 更新${table.classComment}
     *
     * @param updateReqVO 更新信息
     */
    void update${simpleClassName}(@Valid ${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO);

    /**
     * 删除${table.classComment}
     *
     * @param id 编号
     */
    void delete${simpleClassName}(${primaryColumn.javaType} id);

    /**
     * 获得${table.classComment}
     *
     * @param id 编号
     * @return ${table.classComment}
     */
    ${table.className}DO get${simpleClassName}(${primaryColumn.javaType} id);

## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
    /**
     * 获得${table.classComment}分页
     *
     * @param pageReqVO 分页查询
     * @return ${table.classComment}分页
     */
    PageResult<${table.className}DO> get${simpleClassName}Page(${sceneEnum.prefixClass}${table.className}PageReqVO pageReqVO);
#else
    /**
     * 获得${table.classComment}列表
     *
     * @param listReqVO 查询条件
     * @return ${table.classComment}列表
     */
    List<${table.className}DO> get${simpleClassName}List(${sceneEnum.prefixClass}${table.className}ListReqVO listReqVO);
#end

## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subPrimaryColumn = $subPrimaryColumns.get($index))##当前 primary 字段
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
#set ($subClassNameVar = $subClassNameVars.get($index))
    // ==================== 子表（$subTable.classComment） ====================

## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )
    /**
     * 获得${subTable.classComment}分页
     *
     * @param pageReqVO 分页查询
     * @param ${subJoinColumn.javaField} ${subJoinColumn.columnComment}
     * @return ${subTable.classComment}分页
     */
    PageResult<${subTable.className}DO> get${subSimpleClassName}Page(PageParam pageReqVO, ${subJoinColumn.javaType} ${subJoinColumn.javaField});

## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
    #if ( $subTable.subJoinMany )
    /**
     * 获得${subTable.classComment}列表
     *
     * @param ${subJoinColumn.javaField} ${subJoinColumn.columnComment}
     * @return ${subTable.classComment}列表
     */
    List<${subTable.className}DO> get${subSimpleClassName}ListBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField});

    #else
    /**
     * 获得${subTable.classComment}
     *
     * @param ${subJoinColumn.javaField} ${subJoinColumn.columnComment}
     * @return ${subTable.classComment}
     */
    ${subTable.className}DO get${subSimpleClassName}By${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField});

    #end
#end
## 特殊：MASTER_ERP 时，支持单个的新增、修改、删除操作
#if ( $table.templateType == 11 )
    /**
     * 创建${subTable.classComment}
     *
     * @param ${subClassNameVar} 创建信息
     * @return 编号
     */
    ${subPrimaryColumn.javaType} create${subSimpleClassName}(@Valid ${subTable.className}DO ${subClassNameVar});

    /**
     * 更新${subTable.classComment}
     *
     * @param ${subClassNameVar} 更新信息
     */
    void update${subSimpleClassName}(@Valid ${subTable.className}DO ${subClassNameVar});

    /**
     * 删除${subTable.classComment}
     *
     * @param id 编号
     */
    void delete${subSimpleClassName}(${subPrimaryColumn.javaType} id);

	/**
	 * 获得${subTable.classComment}
	 *
	 * @param id 编号
     * @return ${subTable.classComment}
	 */
    ${subTable.className}DO get${subSimpleClassName}(${subPrimaryColumn.javaType} id);

#end
#end
}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (63, 3, 'serviceImpl', 'service实现类', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/service/${table.businessName}/${table.className}ServiceImpl.java', 'codegen/java/service/serviceImpl.vm', 'package ${basePackage}.module.${table.moduleName}.service.${table.businessName};

import org.springframework.stereotype.Service;
import ${jakartaPackage}.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
#end
import ${PageResultClassName};
import ${PageParamClassName};
import ${BeanUtils};

import ${basePackage}.module.${table.moduleName}.dal.mysql.${table.businessName}.${table.className}Mapper;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
import ${basePackage}.module.${subTable.moduleName}.dal.mysql.${subTable.businessName}.${subTable.className}Mapper;
#end

import static ${ServiceExceptionUtilClassName}.exception;
import static ${basePackage}.module.${table.moduleName}.enums.ErrorCodeConstants.*;

/**
 * ${table.classComment} Service 实现类
 *
 * @author ${table.author}
 */
@Service
@Validated
public class ${table.className}ServiceImpl implements ${table.className}Service {

    @Resource
    private ${table.className}Mapper ${classNameVar}Mapper;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
    @Resource
    private ${subTable.className}Mapper ${subClassNameVars.get($index)}Mapper;
#end

    @Override
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11 )
    @Transactional(rollbackFor = Exception.class)
#end
    public ${primaryColumn.javaType} create${simpleClassName}(${sceneEnum.prefixClass}${table.className}SaveReqVO createReqVO) {
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($TreeParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
#set ($TreeNameJavaField = $treeNameColumn.javaField.substring(0,1).toUpperCase() + ${treeNameColumn.javaField.substring(1)})##首字母大写
        // 校验${treeParentColumn.columnComment}的有效性
        validateParent${simpleClassName}(null, createReqVO.get${TreeParentJavaField}());
        // 校验${treeNameColumn.columnComment}的唯一性
        validate${simpleClassName}${TreeNameJavaField}Unique(null, createReqVO.get${TreeParentJavaField}(), createReqVO.get${TreeNameJavaField}());

#end
        // 插入
        ${table.className}DO ${classNameVar} = BeanUtils.toBean(createReqVO, ${table.className}DO.class);
        ${classNameVar}Mapper.insert(${classNameVar});
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11 )

        // 插入子表
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
    #if ( $subTable.subJoinMany)
        create${subSimpleClassName}List(${classNameVar}.getId(), createReqVO.get${subSimpleClassNames.get($index)}s());
    #else
        create${subSimpleClassName}(${classNameVar}.getId(), createReqVO.get${subSimpleClassNames.get($index)}());
    #end
#end
#end
        // 返回
        return ${classNameVar}.getId();
    }

    @Override
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11 )
    @Transactional(rollbackFor = Exception.class)
#end
    public void update${simpleClassName}(${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO) {
        // 校验存在
        validate${simpleClassName}Exists(updateReqVO.getId());
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($TreeParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
#set ($TreeNameJavaField = $treeNameColumn.javaField.substring(0,1).toUpperCase() + ${treeNameColumn.javaField.substring(1)})##首字母大写
        // 校验${treeParentColumn.columnComment}的有效性
        validateParent${simpleClassName}(updateReqVO.getId(), updateReqVO.get${TreeParentJavaField}());
        // 校验${treeNameColumn.columnComment}的唯一性
        validate${simpleClassName}${TreeNameJavaField}Unique(updateReqVO.getId(), updateReqVO.get${TreeParentJavaField}(), updateReqVO.get${TreeNameJavaField}());

#end
        // 更新
        ${table.className}DO updateObj = BeanUtils.toBean(updateReqVO, ${table.className}DO.class);
        ${classNameVar}Mapper.updateById(updateObj);
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11)

        // 更新子表
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
    #if ( $subTable.subJoinMany)
        update${subSimpleClassName}List(updateReqVO.getId(), updateReqVO.get${subSimpleClassNames.get($index)}s());
    #else
        update${subSimpleClassName}(updateReqVO.getId(), updateReqVO.get${subSimpleClassNames.get($index)}());
    #end
#end
#end
    }

    @Override
## 特殊：主子表专属逻辑
#if ( $subTables && $subTables.size() > 0)
    @Transactional(rollbackFor = Exception.class)
#end
    public void delete${simpleClassName}(${primaryColumn.javaType} id) {
        // 校验存在
        validate${simpleClassName}Exists(id);
## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($ParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
        // 校验是否有子${table.classComment}
        if (${classNameVar}Mapper.selectCountBy${ParentJavaField}(id) > 0) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_EXITS_CHILDREN);
        }
#end
        // 删除
        ${classNameVar}Mapper.deleteById(id);
## 特殊：主子表专属逻辑
#if ( $subTables && $subTables.size() > 0)

        // 删除子表
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
        delete${subSimpleClassName}By${SubJoinColumnName}(id);
#end
#end
    }

    private void validate${simpleClassName}Exists(${primaryColumn.javaType} id) {
        if (${classNameVar}Mapper.selectById(id) == null) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_NOT_EXISTS);
        }
    }

## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($TreeParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
#set ($TreeNameJavaField = $treeNameColumn.javaField.substring(0,1).toUpperCase() + ${treeNameColumn.javaField.substring(1)})##首字母大写
    private void validateParent${simpleClassName}(Long id, Long ${treeParentColumn.javaField}) {
        if (${treeParentColumn.javaField} == null || ${simpleClassName}DO.${treeParentColumn_javaField_underlineCase.toUpperCase()}_ROOT.equals(${treeParentColumn.javaField})) {
            return;
        }
        // 1. 不能设置自己为父${table.classComment}
        if (Objects.equals(id, ${treeParentColumn.javaField})) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_PARENT_ERROR);
        }
        // 2. 父${table.classComment}不存在
        ${simpleClassName}DO parent${simpleClassName} = ${classNameVar}Mapper.selectById(${treeParentColumn.javaField});
        if (parent${simpleClassName} == null) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_PARENT_NOT_EXITS);
        }
        // 3. 递归校验父${table.classComment}，如果父${table.classComment}是自己的子${table.classComment}，则报错，避免形成环路
        if (id == null) { // id 为空，说明新增，不需要考虑环路
            return;
        }
        for (int i = 0; i < Short.MAX_VALUE; i++) {
            // 3.1 校验环路
            ${treeParentColumn.javaField} = parent${simpleClassName}.get${TreeParentJavaField}();
            if (Objects.equals(id, ${treeParentColumn.javaField})) {
                throw exception(${simpleClassName_underlineCase.toUpperCase()}_PARENT_IS_CHILD);
            }
            // 3.2 继续递归下一级父${table.classComment}
            if (${treeParentColumn.javaField} == null || ${simpleClassName}DO.${treeParentColumn_javaField_underlineCase.toUpperCase()}_ROOT.equals(${treeParentColumn.javaField})) {
                break;
            }
            parent${simpleClassName} = ${classNameVar}Mapper.selectById(${treeParentColumn.javaField});
            if (parent${simpleClassName} == null) {
                break;
            }
        }
    }

    private void validate${simpleClassName}${TreeNameJavaField}Unique(Long id, Long ${treeParentColumn.javaField}, String ${treeNameColumn.javaField}) {
        ${simpleClassName}DO ${classNameVar} = ${classNameVar}Mapper.selectBy${TreeParentJavaField}And${TreeNameJavaField}(${treeParentColumn.javaField}, ${treeNameColumn.javaField});
        if (${classNameVar} == null) {
            return;
        }
        // 如果 id 为空，说明不用比较是否为相同 id 的${table.classComment}
        if (id == null) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_${treeNameColumn_javaField_underlineCase.toUpperCase()}_DUPLICATE);
        }
        if (!Objects.equals(${classNameVar}.getId(), id)) {
            throw exception(${simpleClassName_underlineCase.toUpperCase()}_${treeNameColumn_javaField_underlineCase.toUpperCase()}_DUPLICATE);
        }
    }

#end
    @Override
    public ${table.className}DO get${simpleClassName}(${primaryColumn.javaType} id) {
        return ${classNameVar}Mapper.selectById(id);
    }

## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
    @Override
    public PageResult<${table.className}DO> get${simpleClassName}Page(${sceneEnum.prefixClass}${table.className}PageReqVO pageReqVO) {
        return ${classNameVar}Mapper.selectPage(pageReqVO);
    }
#else
    @Override
    public List<${table.className}DO> get${simpleClassName}List(${sceneEnum.prefixClass}${table.className}ListReqVO listReqVO) {
        return ${classNameVar}Mapper.selectList(listReqVO);
    }
#end

## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($simpleClassNameUnderlineCase = $simpleClassNameUnderlineCases.get($index))
#set ($subPrimaryColumn = $subPrimaryColumns.get($index))##当前 primary 字段
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
#set ($subClassNameVar = $subClassNameVars.get($index))
    // ==================== 子表（$subTable.classComment） ====================

## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )
    @Override
    public PageResult<${subTable.className}DO> get${subSimpleClassName}Page(PageParam pageReqVO, ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return ${subClassNameVars.get($index)}Mapper.selectPage(pageReqVO, ${subJoinColumn.javaField});
    }

## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
    #if ( $subTable.subJoinMany )
    @Override
    public List<${subTable.className}DO> get${subSimpleClassName}ListBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return ${subClassNameVars.get($index)}Mapper.selectListBy${SubJoinColumnName}(${subJoinColumn.javaField});
    }

    #else
    @Override
    public ${subTable.className}DO get${subSimpleClassName}By${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return ${subClassNameVars.get($index)}Mapper.selectBy${SubJoinColumnName}(${subJoinColumn.javaField});
    }

    #end
#end
## 情况一：MASTER_ERP 时，支持单个的新增、修改、删除操作
#if ( $table.templateType == 11 )
    @Override
    public ${subPrimaryColumn.javaType} create${subSimpleClassName}(${subTable.className}DO ${subClassNameVar}) {
## 特殊：一对一时，需要保证只有一条，不能重复插入
#if ( !$subTable.subJoinMany)
        // 校验是否已经存在
        if (${subClassNameVars.get($index)}Mapper.selectBy${SubJoinColumnName}(${subClassNameVar}.get${SubJoinColumnName}()) != null) {
            throw exception(${simpleClassNameUnderlineCase.toUpperCase()}_EXISTS);
        }
        // 插入
#end
        ${subClassNameVars.get($index)}Mapper.insert(${subClassNameVar});
        return ${subClassNameVar}.getId();
    }

    @Override
    public void update${subSimpleClassName}(${subTable.className}DO ${subClassNameVar}) {
        // 校验存在
        validate${subSimpleClassName}Exists(${subClassNameVar}.getId());
        // 更新
        ${subClassNameVar}.setUpdater(null).setUpdateTime(null); // 解决更新情况下：updateTime 不更新
        ${subClassNameVars.get($index)}Mapper.updateById(${subClassNameVar});
    }

    @Override
    public void delete${subSimpleClassName}(${subPrimaryColumn.javaType} id) {
        // 校验存在
        validate${subSimpleClassName}Exists(id);
        // 删除
        ${subClassNameVars.get($index)}Mapper.deleteById(id);
    }

    @Override
    public ${subTable.className}DO get${subSimpleClassName}(${subPrimaryColumn.javaType} id) {
        return ${subClassNameVars.get($index)}Mapper.selectById(id);
    }

    private void validate${subSimpleClassName}Exists(${subPrimaryColumn.javaType} id) {
        if (${subClassNameVar}Mapper.selectById(id) == null) {
            throw exception(${simpleClassNameUnderlineCase.toUpperCase()}_NOT_EXISTS);
        }
    }

## 情况二：非 MASTER_ERP 时，支持批量的新增、修改操作
#else
    #if ( $subTable.subJoinMany)
    private void create${subSimpleClassName}List(${primaryColumn.javaType} ${subJoinColumn.javaField}, List<${subTable.className}DO> list) {
        list.forEach(o -> o.set$SubJoinColumnName(${subJoinColumn.javaField}));
        ${subClassNameVars.get($index)}Mapper.insertBatch(list);
    }

    private void update${subSimpleClassName}List(${primaryColumn.javaType} ${subJoinColumn.javaField}, List<${subTable.className}DO> list) {
        delete${subSimpleClassName}By${SubJoinColumnName}(${subJoinColumn.javaField});
		list.forEach(o -> o.setId(null).setUpdater(null).setUpdateTime(null)); // 解决更新情况下：1）id 冲突；2）updateTime 不更新
        create${subSimpleClassName}List(${subJoinColumn.javaField}, list);
    }

    #else
    private void create${subSimpleClassName}(${primaryColumn.javaType} ${subJoinColumn.javaField}, ${subTable.className}DO ${subClassNameVar}) {
        if (${subClassNameVar} == null) {
            return;
        }
        ${subClassNameVar}.set$SubJoinColumnName(${subJoinColumn.javaField});
        ${subClassNameVars.get($index)}Mapper.insert(${subClassNameVar});
    }

    private void update${subSimpleClassName}(${primaryColumn.javaType} ${subJoinColumn.javaField}, ${subTable.className}DO ${subClassNameVar}) {
        if (${subClassNameVar} == null) {
			return;
        }
        ${subClassNameVar}.set$SubJoinColumnName(${subJoinColumn.javaField});
        ${subClassNameVar}.setUpdater(null).setUpdateTime(null); // 解决更新情况下：updateTime 不更新
        ${subClassNameVars.get($index)}Mapper.insertOrUpdate(${subClassNameVar});
    }

    #end
#end
    private void delete${subSimpleClassName}By${SubJoinColumnName}(${primaryColumn.javaType} ${subJoinColumn.javaField}) {
        ${subClassNameVars.get($index)}Mapper.deleteBy${SubJoinColumnName}(${subJoinColumn.javaField});
    }

#end
}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (64, 3, 'mapper_xml', 'myabtis的xml', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/resources/mapper/${table.businessName}/${table.className}Mapper.xml', 'codegen/java/dal/mapper.xml.vm', '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${basePackage}.module.${table.moduleName}.dal.mysql.${table.businessName}.${table.className}Mapper">

    <!--
        一般情况下，尽可能使用 Mapper 进行 CRUD 增删改查即可。
        无法满足的场景，例如说多表关联查询，才使用 XML 编写 SQL。
        代码生成器暂时只生成 Mapper XML 文件本身，更多推荐 MybatisX 快速开发插件来生成查询。
        文档可见：https://www.iocoder.cn/MyBatis/x-plugins/
     -->

</mapper>
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (65, 3, 'mapper_sub', '子表的java mybatis的mapper接口', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/dal/mysql/${table.businessName}/${subTables[subIndex].className}Mapper.java', 'codegen/java/dal/mapper_sub.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subJoinColumnsList.get($subIndex))##当前字段数组
#set ($subJoinColumn = $subJoinColumns.get($subIndex))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
package ${basePackage}.module.${subTable.moduleName}.dal.mysql.${subTable.businessName};

import java.util.*;

import ${PageResultClassName};
import ${PageParamClassName};
import ${QueryWrapperClassName};
import ${BaseMapperClassName};
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
import org.apache.ibatis.annotations.Mapper;

/**
 * ${subTable.classComment} Mapper
 *
 * @author ${subTable.author}
 */
@Mapper
public interface ${subTable.className}Mapper extends BaseMapperX<${subTable.className}DO> {

## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )
    default PageResult<${subTable.className}DO> selectPage(PageParam reqVO, ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return selectPage(reqVO, new LambdaQueryWrapperX<${subTable.className}DO>()
            .eq(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField})
            .orderByDesc(${subTable.className}DO::getId));## 大多数情况下，id 倒序

    }
## 主表与子表是一对一时 
    #if (!$subTable.subJoinMany)
        default ${subTable.className}DO selectBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return selectOne(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField});
        }
    #end

## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
    #if ( $subTable.subJoinMany)
    default List<${subTable.className}DO> selectListBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return selectList(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField});
    }

    #else
    default ${subTable.className}DO selectBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return selectOne(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField});
    }

    #end
    #end
    default int deleteBy${SubJoinColumnName}(${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return delete(${subTable.className}DO::get${SubJoinColumnName}, ${subJoinColumn.javaField});
    }

}

', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (66, 3, 'mapper', 'java mybatis的mapper接口', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/dal/mysql/${table.businessName}/${table.className}Mapper.java', 'codegen/java/dal/mapper.vm', 'package ${basePackage}.module.${table.moduleName}.dal.mysql.${table.businessName};

import java.util.*;

import ${PageResultClassName};
import ${QueryWrapperClassName};
import ${BaseMapperClassName};
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
import org.apache.ibatis.annotations.Mapper;
import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;

## 字段模板
#macro(listCondition)
#foreach ($column in $columns)
#if (${column.listOperation})
#set ($JavaField = $column.javaField.substring(0,1).toUpperCase() + ${column.javaField.substring(1)})##首字母大写
#if (${column.listOperationCondition} == "=")##情况一，= 的时候
                .eqIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "!=")##情况二，!= 的时候
                .neIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == ">")##情况三，> 的时候
                .gtIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == ">=")##情况四，>= 的时候
                .geIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "<")##情况五，< 的时候
                .ltIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "<=")##情况五，<= 的时候
                .leIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "LIKE")##情况七，Like 的时候
                .likeIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#if (${column.listOperationCondition} == "BETWEEN")##情况八，Between 的时候
                .betweenIfPresent(${table.className}DO::get${JavaField}, reqVO.get${JavaField}())
#end
#end
#end
#end
/**
 * ${table.classComment} Mapper
 *
 * @author ${table.author}
 */
@Mapper
public interface ${table.className}Mapper extends BaseMapperX<${table.className}DO> {

## 特殊：树表专属逻辑（树不需要分页接口）
#if ( $table.templateType != 2 )
    default PageResult<${table.className}DO> selectPage(${sceneEnum.prefixClass}${table.className}PageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<${table.className}DO>()
			#listCondition()
                .orderByDesc(${table.className}DO::getId));## 大多数情况下，id 倒序

    }
#else
    default List<${table.className}DO> selectList(${sceneEnum.prefixClass}${table.className}ListReqVO reqVO) {
        return selectList(new LambdaQueryWrapperX<${table.className}DO>()
			#listCondition()
                .orderByDesc(${table.className}DO::getId));## 大多数情况下，id 倒序

    }
#end

## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
#set ($TreeParentJavaField = $treeParentColumn.javaField.substring(0,1).toUpperCase() + ${treeParentColumn.javaField.substring(1)})##首字母大写
#set ($TreeNameJavaField = $treeNameColumn.javaField.substring(0,1).toUpperCase() + ${treeNameColumn.javaField.substring(1)})##首字母大写
	default ${table.className}DO selectBy${TreeParentJavaField}And${TreeNameJavaField}(Long ${treeParentColumn.javaField}, String ${treeNameColumn.javaField}) {
	    return selectOne(${table.className}DO::get${TreeParentJavaField}, ${treeParentColumn.javaField}, ${table.className}DO::get${TreeNameJavaField}, ${treeNameColumn.javaField});
	}

    default Long selectCountBy${TreeParentJavaField}(${treeParentColumn.javaType} ${treeParentColumn.javaField}) {
        return selectCount(${table.className}DO::get${TreeParentJavaField}, ${treeParentColumn.javaField});
    }

#end
}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (67, 3, 'do_sub', '子表实体类', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/dal/dataobject/${table.businessName}/${subTables[subIndex].className}DO.java', 'codegen/java/dal/do_sub.vm', '#set ($subTable = $subTables.get($subIndex))##当前表
#set ($subColumns = $subColumnsList.get($subIndex))##当前字段数组
package ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName};

import lombok.*;
import java.util.*;
#foreach ($column in $subColumns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#end
#if (${column.javaType} == "LocalDateTime")
import java.time.LocalDateTime;
#end
#end
import com.baomidou.mybatisplus.annotation.*;
import ${BaseDOClassName};

/**
 * ${subTable.classComment} DO
 *
 * @author ${subTable.author}
 */
@TableName("${subTable.tableName.toLowerCase()}")
@KeySequence("${subTable.tableName.toLowerCase()}_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ${subTable.className}DO extends BaseDO {

#foreach ($column in $subColumns)
#if (!${baseDOFields.contains(${column.javaField})})##排除 BaseDO 的字段
    /**
     * ${column.columnComment}
    #if ("$!column.dictType" != "")##处理枚举值
     *
     * 枚举 {@link TODO ${column.dictType} 对应的类}
    #end
     */
    #if (${column.primaryKey})##处理主键
    @TableId#if (${column.javaType} == \'String\')(type = IdType.INPUT)#end
    #end
    private ${column.javaType} ${column.javaField};
#end
#end

}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (68, 3, 'do', '实体类', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/dal/dataobject/${table.businessName}/${table.className}DO.java', 'codegen/java/dal/do.vm', 'package ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName};

import lombok.*;
import java.util.*;
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#end
#if (${column.javaType} == "LocalDateTime")
import java.time.LocalDateTime;
#end
#end
import com.baomidou.mybatisplus.annotation.*;
import ${BaseDOClassName};

/**
 * ${table.classComment} DO
 *
 * @author ${table.author}
 */
@TableName("${table.tableName.toLowerCase()}")
@KeySequence("${table.tableName.toLowerCase()}_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ${table.className}DO extends BaseDO {

## 特殊：树表专属逻辑
#if ( $table.templateType == 2 )
    public static final Long ${treeParentColumn_javaField_underlineCase.toUpperCase()}_ROOT = 0L;

#end
#foreach ($column in $columns)
#if (!${baseDOFields.contains(${column.javaField})})##排除 BaseDO 的字段
    /**
     * ${column.columnComment}
    #if ("$!column.dictType" != "")##处理枚举值
     *
     * 枚举 {@link TODO ${column.dictType} 对应的类}
    #end
     */
    #if (${column.primaryKey})##处理主键
    @TableId#if (${column.javaType} == \'String\')(type = IdType.INPUT)#end
    #end
    private ${column.javaType} ${column.javaField};
#end
#end

}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (69, 3, 'controller', 'controller', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/${sceneEnum.prefixClass}${table.className}Controller.java', 'codegen/java/controller/controller.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName};

import org.springframework.web.bind.annotation.*;
import ${jakartaPackage}.annotation.Resource;
import org.springframework.validation.annotation.Validated;
#if ($sceneEnum.scene == 1)import org.springframework.security.access.prepost.PreAuthorize;#end

import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Operation;

import ${jakartaPackage}.validation.constraints.*;
import ${jakartaPackage}.validation.*;
import ${jakartaPackage}.servlet.http.*;
import java.util.*;
import java.io.IOException;

import ${PageParamClassName};
import ${PageResultClassName};
import ${CommonResultClassName};
import ${BeanUtils};
import static ${CommonResultClassName}.success;

import ${ExcelUtilsClassName};

import ${ApiAccessLogClassName};
import static ${OperateTypeEnumClassName}.*;

import ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo.*;
import ${basePackage}.module.${table.moduleName}.dal.dataobject.${table.businessName}.${table.className}DO;
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
#end
import ${basePackage}.module.${table.moduleName}.service.${table.businessName}.${table.className}Service;

@Tag(name = "${sceneEnum.name} - ${table.classComment}")
@RestController
##二级的 businessName 暂时不算在 HTTP 路径上，可以根据需要写
@RequestMapping("/${table.moduleName}/${simpleClassName_strikeCase}")
@Validated
public class ${sceneEnum.prefixClass}${table.className}Controller {

    @Resource
    private ${table.className}Service ${classNameVar}Service;

    @PostMapping("/create")
    @Operation(summary = "创建${table.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:create\')")
#end
    public CommonResult<${primaryColumn.javaType}> create${simpleClassName}(@Valid @RequestBody ${sceneEnum.prefixClass}${table.className}SaveReqVO createReqVO) {
        return success(${classNameVar}Service.create${simpleClassName}(createReqVO));
    }

    @PutMapping("/update")
    @Operation(summary = "更新${table.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:update\')")
#end
    public CommonResult<Boolean> update${simpleClassName}(@Valid @RequestBody ${sceneEnum.prefixClass}${table.className}SaveReqVO updateReqVO) {
        ${classNameVar}Service.update${simpleClassName}(updateReqVO);
        return success(true);
    }

    @DeleteMapping("/delete")
    @Operation(summary = "删除${table.classComment}")
    @Parameter(name = "id", description = "编号", required = true)
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:delete\')")
#end
    public CommonResult<Boolean> delete${simpleClassName}(@RequestParam("id") ${primaryColumn.javaType} id) {
        ${classNameVar}Service.delete${simpleClassName}(id);
        return success(true);
    }

    @GetMapping("/get")
    @Operation(summary = "获得${table.classComment}")
    @Parameter(name = "id", description = "编号", required = true, example = "1024")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<${sceneEnum.prefixClass}${table.className}RespVO> get${simpleClassName}(@RequestParam("id") ${primaryColumn.javaType} id) {
        ${table.className}DO ${classNameVar} = ${classNameVar}Service.get${simpleClassName}(id);
        return success(BeanUtils.toBean(${classNameVar}, ${sceneEnum.prefixClass}${table.className}RespVO.class));
    }

#if ( $table.templateType != 2 )
    @GetMapping("/page")
    @Operation(summary = "获得${table.classComment}分页")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<PageResult<${sceneEnum.prefixClass}${table.className}RespVO>> get${simpleClassName}Page(@Valid ${sceneEnum.prefixClass}${table.className}PageReqVO pageReqVO) {
        PageResult<${table.className}DO> pageResult = ${classNameVar}Service.get${simpleClassName}Page(pageReqVO);
        return success(BeanUtils.toBean(pageResult, ${sceneEnum.prefixClass}${table.className}RespVO.class));
    }

## 特殊：树表专属逻辑（树不需要分页接口）
#else
    @GetMapping("/list")
    @Operation(summary = "获得${table.classComment}列表")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<List<${sceneEnum.prefixClass}${table.className}RespVO>> get${simpleClassName}List(@Valid ${sceneEnum.prefixClass}${table.className}ListReqVO listReqVO) {
        List<${table.className}DO> list = ${classNameVar}Service.get${simpleClassName}List(listReqVO);
        return success(BeanUtils.toBean(list, ${sceneEnum.prefixClass}${table.className}RespVO.class));
    }

#end
    @GetMapping("/export-excel")
    @Operation(summary = "导出${table.classComment} Excel")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:export\')")
#end
    @ApiAccessLog(operateType = EXPORT)
#if ( $table.templateType != 2 )
    public void export${simpleClassName}Excel(@Valid ${sceneEnum.prefixClass}${table.className}PageReqVO pageReqVO,
              HttpServletResponse response) throws IOException {
        pageReqVO.setPageSize(PageParam.PAGE_SIZE_NONE);
        List<${table.className}DO> list = ${classNameVar}Service.get${simpleClassName}Page(pageReqVO).getList();
        // 导出 Excel
        ExcelUtils.write(response, "${table.classComment}.xls", "数据", ${sceneEnum.prefixClass}${table.className}RespVO.class,
                        BeanUtils.toBean(list, ${sceneEnum.prefixClass}${table.className}RespVO.class));
    }
## 特殊：树表专属逻辑（树不需要分页接口）
#else
    public void export${simpleClassName}Excel(@Valid ${sceneEnum.prefixClass}${table.className}ListReqVO listReqVO,
              HttpServletResponse response) throws IOException {
        List<${table.className}DO> list = ${classNameVar}Service.get${simpleClassName}List(listReqVO);
        // 导出 Excel
        ExcelUtils.write(response, "${table.classComment}.xls", "数据", ${table.className}RespVO.class,
                        BeanUtils.toBean(list, ${table.className}RespVO.class));
    }
#end

## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
#set ($subSimpleClassName = $subSimpleClassNames.get($index))
#set ($subPrimaryColumn = $subPrimaryColumns.get($index))##当前 primary 字段
#set ($subJoinColumn = $subJoinColumns.get($index))##当前 join 字段
#set ($SubJoinColumnName = $subJoinColumn.javaField.substring(0,1).toUpperCase() + ${subJoinColumn.javaField.substring(1)})##首字母大写
#set ($subSimpleClassName_strikeCase = $subSimpleClassName_strikeCases.get($index))
#set ($subJoinColumn_strikeCase = $subJoinColumn_strikeCases.get($index))
#set ($subClassNameVar = $subClassNameVars.get($index))
    // ==================== 子表（$subTable.classComment） ====================

## 情况一：MASTER_ERP 时，需要分查询页子表
#if ( $table.templateType == 11 )
    @GetMapping("/${subSimpleClassName_strikeCase}/page")
    @Operation(summary = "获得${subTable.classComment}分页")
    @Parameter(name = "${subJoinColumn.javaField}", description = "${subJoinColumn.columnComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<PageResult<${subTable.className}DO>> get${subSimpleClassName}Page(PageParam pageReqVO,
                                                                                        @RequestParam("${subJoinColumn.javaField}") ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return success(${classNameVar}Service.get${subSimpleClassName}Page(pageReqVO, ${subJoinColumn.javaField}));
    }

## 情况二：非 MASTER_ERP 时，需要列表查询子表
#else
    #if ( $subTable.subJoinMany )
    @GetMapping("/${subSimpleClassName_strikeCase}/list-by-${subJoinColumn_strikeCase}")
    @Operation(summary = "获得${subTable.classComment}列表")
    @Parameter(name = "${subJoinColumn.javaField}", description = "${subJoinColumn.columnComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<List<${subTable.className}DO>> get${subSimpleClassName}ListBy${SubJoinColumnName}(@RequestParam("${subJoinColumn.javaField}") ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return success(${classNameVar}Service.get${subSimpleClassName}ListBy${SubJoinColumnName}(${subJoinColumn.javaField}));
    }

    #else
    @GetMapping("/${subSimpleClassName_strikeCase}/get-by-${subJoinColumn_strikeCase}")
    @Operation(summary = "获得${subTable.classComment}")
    @Parameter(name = "${subJoinColumn.javaField}", description = "${subJoinColumn.columnComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
    public CommonResult<${subTable.className}DO> get${subSimpleClassName}By${SubJoinColumnName}(@RequestParam("${subJoinColumn.javaField}") ${subJoinColumn.javaType} ${subJoinColumn.javaField}) {
        return success(${classNameVar}Service.get${subSimpleClassName}By${SubJoinColumnName}(${subJoinColumn.javaField}));
    }

    #end
#end
## 特殊：MASTER_ERP 时，支持单个的新增、修改、删除操作
#if ( $table.templateType == 11 )
    @PostMapping("/${subSimpleClassName_strikeCase}/create")
    @Operation(summary = "创建${subTable.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:create\')")
#end
    public CommonResult<${subPrimaryColumn.javaType}> create${subSimpleClassName}(@Valid @RequestBody ${subTable.className}DO ${subClassNameVar}) {
        return success(${classNameVar}Service.create${subSimpleClassName}(${subClassNameVar}));
    }

    @PutMapping("/${subSimpleClassName_strikeCase}/update")
    @Operation(summary = "更新${subTable.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:update\')")
#end
    public CommonResult<Boolean> update${subSimpleClassName}(@Valid @RequestBody ${subTable.className}DO ${subClassNameVar}) {
        ${classNameVar}Service.update${subSimpleClassName}(${subClassNameVar});
        return success(true);
    }

    @DeleteMapping("/${subSimpleClassName_strikeCase}/delete")
    @Parameter(name = "id", description = "编号", required = true)
    @Operation(summary = "删除${subTable.classComment}")
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:delete\')")
#end
    public CommonResult<Boolean> delete${subSimpleClassName}(@RequestParam("id") ${subPrimaryColumn.javaType} id) {
        ${classNameVar}Service.delete${subSimpleClassName}(id);
        return success(true);
    }

	@GetMapping("/${subSimpleClassName_strikeCase}/get")
	@Operation(summary = "获得${subTable.classComment}")
	@Parameter(name = "id", description = "编号", required = true)
#if ($sceneEnum.scene == 1)
    @PreAuthorize("@ss.hasPermission(\'${permissionPrefix}:query\')")
#end
	public CommonResult<${subTable.className}DO> get${subSimpleClassName}(@RequestParam("id") ${subPrimaryColumn.javaType} id) {
	    return success(${classNameVar}Service.get${subSimpleClassName}(id));
	}

#end
#end
}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 23:43:14', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (70, 3, 'SaveReqVO', '保存请求VO', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/vo/${sceneEnum.prefixClass}${table.className}SaveReqVO.java', 'codegen/java/controller/vo/saveReqVO.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import java.util.*;
import ${jakartaPackage}.validation.constraints.*;
## 处理 BigDecimal 字段的引入
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#break
#end
#end
## 处理 LocalDateTime 字段的引入
#foreach ($column in $columns)
#if ((${column.createOperation} || ${column.updateOperation}) && ${column.javaType} == "LocalDateTime")
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;
#break
#end
#end
## 特殊：主子表专属逻辑
#foreach ($subTable in $subTables)
import ${basePackage}.module.${subTable.moduleName}.dal.dataobject.${subTable.businessName}.${subTable.className}DO;
#end

@Schema(description = "${sceneEnum.name} - ${table.classComment}新增/修改 Request VO")
@Data
public class ${sceneEnum.prefixClass}${table.className}SaveReqVO {

## 逐个处理字段
#foreach ($column in $columns)
#if (${column.createOperation} || ${column.updateOperation})
## 1. 处理 Swagger 注解
    @Schema(description = "${column.columnComment}"#if (!${column.nullable}), requiredMode = Schema.RequiredMode.REQUIRED#end#if ("$!column.example" != ""), example = "${column.example}"#end)
## 2. 处理 Validator 参数校验
#if (!${column.nullable} && !${column.primaryKey})
#if (${column.javaType} == \'String\')
    @NotEmpty(message = "${column.columnComment}不能为空")
#else
    @NotNull(message = "${column.columnComment}不能为空")
#end
#end
## 3. 处理字段定义
    private ${column.javaType} ${column.javaField};

#end
#end
## 特殊：主子表专属逻辑（非 ERP 模式）
#if ( $subTables && $subTables.size() > 0 && $table.templateType != 11 )
#foreach ($subTable in $subTables)
#set ($index = $foreach.count - 1)
    #if ( $subTable.subJoinMany)
    @Schema(description = "${subTable.classComment}列表")
    private List<${subTable.className}DO> ${subClassNameVars.get($index)}s;

    #else
    @Schema(description = "${subTable.classComment}")
    private ${subTable.className}DO ${subClassNameVars.get($index)};

    #end
#end
#end
}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (71, 3, 'RespVO', '返回值VO', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/vo/${sceneEnum.prefixClass}${table.className}RespVO.java', 'codegen/java/controller/vo/respVO.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import java.util.*;
## 处理 BigDecimal 字段的引入
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#break
#end
#end
## 处理 LocalDateTime 字段的引入
#foreach ($column in $columns)
#if (${column.listOperationResult} && ${column.javaType} == "LocalDateTime")
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;
#break
#end
#end
## 处理 Excel 导出
import com.alibaba.excel.annotation.*;
#foreach ($column in $columns)
#if ("$!column.dictType" != "")## 有设置数据字典
import ${DictFormatClassName};
import ${DictConvertClassName};
#break
#end
#end

@Schema(description = "${sceneEnum.name} - ${table.classComment} Response VO")
@Data
@ExcelIgnoreUnannotated
public class ${sceneEnum.prefixClass}${table.className}RespVO {

## 逐个处理字段
#foreach ($column in $columns)
#if (${column.listOperationResult})
## 1. 处理 Swagger 注解
    @Schema(description = "${column.columnComment}"#if (!${column.nullable}), requiredMode = Schema.RequiredMode.REQUIRED#end#if ("$!column.example" != ""), example = "${column.example}"#end)
## 2. 处理 Excel 导出
#if ("$!column.dictType" != "")##处理枚举值
    @ExcelProperty(value = "${column.columnComment}", converter = DictConvert.class)
    @DictFormat("${column.dictType}") // TODO 代码优化：建议设置到对应的 DictTypeConstants 枚举类中
#else
    @ExcelProperty("${column.columnComment}")
#end
## 3. 处理字段定义
    private ${column.javaType} ${column.javaField};

#end
#end
}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (72, 3, 'ListReqVO', '全部列表请求VO', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/vo/${sceneEnum.prefixClass}${table.className}ListReqVO.java', 'codegen/java/controller/vo/listReqVO.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo;

import lombok.*;
import java.util.*;
import io.swagger.v3.oas.annotations.media.Schema;
import ${PageParamClassName};
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#break
#end
#end
## 处理 LocalDateTime 字段的引入
#foreach ($column in $columns)
#if (${column.listOperation} && ${column.javaType} == "LocalDateTime")
import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;

import static ${DateUtilsClassName}.FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND;
#break
#end
#end
## 字段模板
#macro(columnTpl $prefix $prefixStr)
    @Schema(description = "${prefixStr}${column.columnComment}"#if ("$!column.example" != ""), example = "${column.example}"#end)
    private ${column.javaType}#if ("$!prefix" != "") ${prefix}${JavaField}#else ${column.javaField}#end;
#end

@Schema(description = "${sceneEnum.name} - ${table.classComment}列表 Request VO")
@Data
public class ${sceneEnum.prefixClass}${table.className}ListReqVO {

#foreach ($column in $columns)
#if (${column.listOperation})##查询操作
#if (${column.listOperationCondition} == "BETWEEN")## 情况一，Between 的时候
    @Schema(description = "${column.columnComment}"#if ("$!column.example" != ""), example = "${column.example}"#end)
    @DateTimeFormat(pattern = FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND)
    private ${column.javaType}[] ${column.javaField};
#else##情况二，非 Between 的时间
    #columnTpl(\'\', \'\')
#end

#end
#end
}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
INSERT INTO `ruoyi-vue-pro`.ucg_code_template (id, project_id, template_name, template_description, template_type, template_type_value, file_type, file_path_expression, original_path, template_content, creator, create_time, updater, update_time, deleted) VALUES (73, 3, 'PageReqVO', '分页请求VO', 'SERVER', 'SERVER', 'java', 'yudao-module-${table.moduleName}/yudao-module-${table.moduleName}-biz/src/main/java/${basePackageFilePath}/module/${table.moduleName}/controller/${sceneEnum.basePackage}/${table.businessName}/vo/${sceneEnum.prefixClass}${table.className}PageReqVO.java', 'codegen/java/controller/vo/pageReqVO.vm', 'package ${basePackage}.module.${table.moduleName}.controller.${sceneEnum.basePackage}.${table.businessName}.vo;

import lombok.*;
import java.util.*;
import io.swagger.v3.oas.annotations.media.Schema;
import ${PageParamClassName};
#foreach ($column in $columns)
#if (${column.javaType} == "BigDecimal")
import java.math.BigDecimal;
#break
#end
#end
## 处理 LocalDateTime 字段的引入
#foreach ($column in $columns)
#if (${column.listOperationCondition} && ${column.javaType} == "LocalDateTime")
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;

import static ${DateUtilsClassName}.FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND;
#break
#end
#end
## 字段模板
#macro(columnTpl $prefix $prefixStr)
    @Schema(description = "${prefixStr}${column.columnComment}"#if ("$!column.example" != ""), example = "${column.example}"#end)
    private ${column.javaType}#if ("$!prefix" != "") ${prefix}${JavaField}#else ${column.javaField}#end;
#end

@Schema(description = "${sceneEnum.name} - ${table.classComment}分页 Request VO")
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class ${sceneEnum.prefixClass}${table.className}PageReqVO extends PageParam {

#foreach ($column in $columns)
#if (${column.listOperation})##查询操作
#if (${column.listOperationCondition} == "BETWEEN")## 情况一，Between 的时候
    @Schema(description = "${column.columnComment}"#if ("$!column.example" != ""), example = "${column.example}"#end)
    @DateTimeFormat(pattern = FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND)
    private ${column.javaType}[] ${column.javaField};
#else##情况二，非 Between 的时间
    #columnTpl(\'\', \'\')
#end

#end
#end
}
', '1', '2024-12-17 21:48:50', '1', '2024-12-17 21:48:50', false);
