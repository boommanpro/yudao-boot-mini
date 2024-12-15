package cn.iocoder.yudao.module.ucg.controller.admin.codetemplate.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import java.util.*;
import javax.validation.constraints.*;

@Schema(description = "管理后台 - 存储代码模板的基本信息新增/修改 Request VO")
@Data
public class CodeTemplateSaveReqVO {

    @Schema(description = "编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "8406")
    private Long id;

    @Schema(description = "项目id", requiredMode = Schema.RequiredMode.REQUIRED, example = "23899")
    private Long projectId;

    @Schema(description = "模板名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "王五")
    @NotEmpty(message = "模板名称不能为空")
    private String templateName;

    @Schema(description = "模板描述", example = "随便")
    private String templateDescription;

    @Schema(description = "模板类型 ", requiredMode = Schema.RequiredMode.REQUIRED, example = "2")
    @NotEmpty(message = "模板类型 不能为空")
    private String templateType;

    @Schema(description = "模板类型值", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotEmpty(message = "模板类型值不能为空")
    private String templateTypeValue;

    @Schema(description = "文件类型", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @NotEmpty(message = "文件类型不能为空")
    private String fileType;

    @Schema(description = "文件路径", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotEmpty(message = "文件路径不能为空")
    private String filePathExpression;

    @Schema(description = "原始路径")
    private String originalPath;

    @Schema(description = "模板内容", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotEmpty(message = "模板内容不能为空")
    private String templateContent;

}