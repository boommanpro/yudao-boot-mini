package cn.iocoder.yudao.module.ucg.controller.admin.codetemplate.vo;

import lombok.*;
import java.util.*;
import io.swagger.v3.oas.annotations.media.Schema;
import cn.iocoder.yudao.framework.common.pojo.PageParam;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;

import static cn.iocoder.yudao.framework.common.util.date.DateUtils.FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND;

@Schema(description = "管理后台 - 存储代码模板的基本信息分页 Request VO")
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class CodeTemplatePageReqVO extends PageParam {

    @Schema(description = "项目id", example = "23899")
    private Long projectId;

    @Schema(description = "模板名称", example = "王五")
    private String templateName;

    @Schema(description = "模板描述", example = "随便")
    private String templateDescription;

    @Schema(description = "模板类型 ", example = "2")
    private String templateType;

    @Schema(description = "模板类型值")
    private String templateTypeValue;

    @Schema(description = "文件类型", example = "1")
    private String fileType;

    @Schema(description = "文件路径")
    private String filePathExpression;

    @Schema(description = "原始路径")
    private String originalPath;

    @Schema(description = "模板内容")
    private String templateContent;

    @Schema(description = "创建时间，默认为当前时间戳")
    @DateTimeFormat(pattern = FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND)
    private LocalDateTime[] createTime;

}