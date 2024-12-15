package cn.iocoder.yudao.module.ucg.controller.admin.project.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import java.util.*;
import javax.validation.constraints.*;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectVariableDO;

@Schema(description = "管理后台 - 存储项目的基本信息新增/修改 Request VO")
@Data
public class ProjectSaveReqVO {

    @Schema(description = "编号，自增，唯一标识一个项目", requiredMode = Schema.RequiredMode.REQUIRED, example = "18178")
    private Long id;

    @Schema(description = "项目名称，不能为空", requiredMode = Schema.RequiredMode.REQUIRED, example = "芋艿")
    @NotEmpty(message = "项目名称，不能为空不能为空")
    private String projectName;

    @Schema(description = "项目描述，文本类型，可以为空", example = "随便")
    private String projectDescription;

    @Schema(description = "启动状态", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @NotNull(message = "启动状态不能为空")
    private Boolean enableStatus;

    @Schema(description = "存储与项目相关的变量信息列表")
    private List<ProjectVariableDO> projectVariables;

}
