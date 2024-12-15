package cn.iocoder.yudao.module.ucg.dal.dataobject.codetemplate;

import lombok.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.*;
import cn.iocoder.yudao.framework.mybatis.core.dataobject.BaseDO;

/**
 * 存储代码模板的基本信息 DO
 *
 * @author 管理员
 */
@TableName("ucg_code_template")
@KeySequence("ucg_code_template_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CodeTemplateDO extends BaseDO {

    /**
     * 编号
     */
    @TableId
    private Long id;
    /**
     * 项目id
     */
    private Long projectId;
    /**
     * 模板名称
     */
    private String templateName;
    /**
     * 模板描述
     */
    private String templateDescription;
    /**
     * 模板类型
     *
     * 枚举 {@link TODO template_type 对应的类}
     */
    private String templateType;
    /**
     * 模板类型值
     *
     * 枚举 {@link TODO template_type_value 对应的类}
     */
    private String templateTypeValue;
    /**
     * 文件类型
     *
     * 枚举 {@link TODO code_file_type 对应的类}
     */
    private String fileType;
    /**
     * 文件路径
     */
    private String filePathExpression;
    /**
     * 原始路径
     */
    private String originalPath;
    /**
     * 模板内容
     */
    private String templateContent;

}
