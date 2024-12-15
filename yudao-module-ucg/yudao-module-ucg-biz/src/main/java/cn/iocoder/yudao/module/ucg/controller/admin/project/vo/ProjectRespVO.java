package cn.iocoder.yudao.module.ucg.controller.admin.project.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import java.util.*;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;
import com.alibaba.excel.annotation.*;
import cn.iocoder.yudao.framework.excel.core.annotations.DictFormat;
import cn.iocoder.yudao.framework.excel.core.convert.DictConvert;

@Schema(description = "管理后台 - 存储项目的基本信息 Response VO")
@Data
@ExcelIgnoreUnannotated
public class ProjectRespVO {

    @Schema(description = "编号，自增，唯一标识一个项目", requiredMode = Schema.RequiredMode.REQUIRED, example = "18178")
    @ExcelProperty("编号，自增，唯一标识一个项目")
    private Long id;

    @Schema(description = "项目名称，不能为空", requiredMode = Schema.RequiredMode.REQUIRED, example = "芋艿")
    @ExcelProperty("项目名称，不能为空")
    private String projectName;

    @Schema(description = "项目描述，文本类型，可以为空", example = "随便")
    @ExcelProperty("项目描述，文本类型，可以为空")
    private String projectDescription;

    @Schema(description = "启动状态", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @ExcelProperty(value = "启动状态", converter = DictConvert.class)
    @DictFormat("enable_status") // TODO 代码优化：建议设置到对应的 DictTypeConstants 枚举类中
    private Boolean enableStatus;

    @Schema(description = "创建时间，默认为当前时间戳", requiredMode = Schema.RequiredMode.REQUIRED)
    @ExcelProperty("创建时间，默认为当前时间戳")
    private LocalDateTime createTime;

}