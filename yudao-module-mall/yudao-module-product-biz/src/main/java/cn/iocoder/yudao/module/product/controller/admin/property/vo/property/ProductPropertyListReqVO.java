package cn.iocoder.yudao.module.product.controller.admin.property.vo.property;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Schema(description = "管理后台 - 属性项 List Request VO")
@Data
@ToString(callSuper = true)
public class ProductPropertyListReqVO {

    @Schema(description = "属性名称", example = "颜色")
    private String name;

    // TODO @puhui999：这个查询条件的作用是啥呀？
    @Schema(description = "属性编号的数组", example = "1,2")
    private List<Long> propertyIds;

}
