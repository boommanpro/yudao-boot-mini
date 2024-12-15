package cn.iocoder.yudao.module.ucg.controller.admin.project.vo;

import lombok.*;
import java.util.*;
import io.swagger.v3.oas.annotations.media.Schema;
import cn.iocoder.yudao.framework.common.pojo.PageParam;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;

import static cn.iocoder.yudao.framework.common.util.date.DateUtils.FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND;

@Schema(description = "管理后台 - 存储项目的基本信息分页 Request VO")
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
public class ProjectPageReqVO extends PageParam {

    @Schema(description = "项目名称，不能为空", example = "芋艿")
    private String projectName;

    @Schema(description = "项目描述，文本类型，可以为空", example = "随便")
    private String projectDescription;

    @Schema(description = "启动状态", example = "1")
    private Boolean enableStatus;

    @Schema(description = "创建时间，默认为当前时间戳")
    @DateTimeFormat(pattern = FORMAT_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND)
    private LocalDateTime[] createTime;

}