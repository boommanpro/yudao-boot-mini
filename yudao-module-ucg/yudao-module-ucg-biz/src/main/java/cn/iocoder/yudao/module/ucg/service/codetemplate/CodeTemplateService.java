package cn.iocoder.yudao.module.ucg.service.codetemplate;

import java.util.*;
import javax.validation.*;
import cn.iocoder.yudao.module.ucg.controller.admin.codetemplate.vo.*;
import cn.iocoder.yudao.module.ucg.dal.dataobject.codetemplate.CodeTemplateDO;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectVariableDO;

/**
 * 存储代码模板的基本信息 Service 接口
 *
 * @author 管理员
 */
public interface CodeTemplateService {

    /**
     * 创建存储代码模板的基本信息
     *
     * @param createReqVO 创建信息
     * @return 编号
     */
    Long createCodeTemplate(@Valid CodeTemplateSaveReqVO createReqVO);

    /**
     * 更新存储代码模板的基本信息
     *
     * @param updateReqVO 更新信息
     */
    void updateCodeTemplate(@Valid CodeTemplateSaveReqVO updateReqVO);

    /**
     * 删除存储代码模板的基本信息
     *
     * @param id 编号
     */
    void deleteCodeTemplate(Long id);

    /**
     * 获得存储代码模板的基本信息
     *
     * @param id 编号
     * @return 存储代码模板的基本信息
     */
    CodeTemplateDO getCodeTemplate(Long id);

    /**
     * 获得存储代码模板的基本信息分页
     *
     * @param pageReqVO 分页查询
     * @return 存储代码模板的基本信息分页
     */
    PageResult<CodeTemplateDO> getCodeTemplatePage(CodeTemplatePageReqVO pageReqVO);

    List<CodeTemplateDO> loadCodeTemplateByFrontType(String frontType);

    List<ProjectVariableDO> queryVariables();
}
