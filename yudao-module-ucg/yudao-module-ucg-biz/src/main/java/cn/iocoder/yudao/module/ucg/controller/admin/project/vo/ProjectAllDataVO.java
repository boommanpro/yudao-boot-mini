package cn.iocoder.yudao.module.ucg.controller.admin.project.vo;

import cn.iocoder.yudao.module.ucg.dal.dataobject.codetemplate.CodeTemplateDO;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectVariableDO;
import lombok.Data;

import java.util.List;

@Data
public class ProjectAllDataVO {
    /**
     * 项目名称，不能为空
     */
    private String projectName;
    /**
     * 项目描述，文本类型，可以为空
     */
    private String projectDescription;
    /**
     * 启动状态
     *
     * 枚举 {@link TODO enable_status 对应的类}
     */
    private Boolean enableStatus;

    private List<ProjectVariableDO> projectVariables;

    private List<CodeTemplateDO> codeTemplates;
}
