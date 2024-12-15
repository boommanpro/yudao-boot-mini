package cn.iocoder.yudao.module.ucg.controller.admin.codetemplate.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import java.util.*;
import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;
import com.alibaba.excel.annotation.*;
import cn.iocoder.yudao.framework.excel.core.annotations.DictFormat;
import cn.iocoder.yudao.framework.excel.core.convert.DictConvert;

@Schema(description = "管理后台 - 存储代码模板的基本信息 Response VO")
@Data
@ExcelIgnoreUnannotated
public class CodeTemplateRespVO {

    @Schema(description = "编号", requiredMode = Schema.RequiredMode.REQUIRED, example = "8406")
    @ExcelProperty("编号")
    private Long id;

    @Schema(description = "项目id", requiredMode = Schema.RequiredMode.REQUIRED, example = "23899")
    @ExcelProperty("项目id")
    private Long projectId;

    @Schema(description = "模板名称", requiredMode = Schema.RequiredMode.REQUIRED, example = "王五")
    @ExcelProperty("模板名称")
    private String templateName;

    @Schema(description = "模板描述", example = "随便")
    @ExcelProperty("模板描述")
    private String templateDescription;

    @Schema(description = "模板类型 ", requiredMode = Schema.RequiredMode.REQUIRED, example = "2")
    @ExcelProperty(value = "模板类型 ", converter = DictConvert.class)
    @DictFormat("template_type") // TODO 代码优化：建议设置到对应的 DictTypeConstants 枚举类中
    private String templateType;

    @Schema(description = "模板类型值", requiredMode = Schema.RequiredMode.REQUIRED)
    @ExcelProperty(value = "模板类型值", converter = DictConvert.class)
    @DictFormat("template_type_value") // TODO 代码优化：建议设置到对应的 DictTypeConstants 枚举类中
    private String templateTypeValue;

    @Schema(description = "文件类型", requiredMode = Schema.RequiredMode.REQUIRED, example = "1")
    @ExcelProperty(value = "文件类型", converter = DictConvert.class)
    @DictFormat("code_file_type") // TODO 代码优化：建议设置到对应的 DictTypeConstants 枚举类中
    private String fileType;

    @Schema(description = "文件路径", requiredMode = Schema.RequiredMode.REQUIRED)
    @ExcelProperty("文件路径")
    private String filePathExpression;

    @Schema(description = "原始路径")
    @ExcelProperty("原始路径")
    private String originalPath;

    /**
     * 模板内容
     */
    @Schema(description = "模板内容")
    @ExcelProperty("模板内容")
    private String templateContent;

    @Schema(description = "创建时间", requiredMode = Schema.RequiredMode.REQUIRED)
    @ExcelProperty("创建时间")
    private LocalDateTime createTime;

}
