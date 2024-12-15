package cn.iocoder.yudao.module.ucg.dal.dataobject.project;

import lombok.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.*;
import cn.iocoder.yudao.framework.mybatis.core.dataobject.BaseDO;

/**
 * 存储与项目相关的变量信息 DO
 *
 * @author 管理员
 */
@TableName("ucg_project_variable")
@KeySequence("ucg_project_variable_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProjectVariableDO extends BaseDO {

    /**
     * 编号，自增，唯一标识一个项目变量
     */
    @TableId
    private Long id;
    /**
     * 工厂ID，与`ucg_project`表的`id`相关联，标识所属项目
     */
    private Long projectId;
    /**
     * 变量名称，不能为空
     */
    private String variableName;
    /**
     * 表达式类型，标识变量的表达式类型，不能为空
     */
    private String expressionType;
    /**
     * 变量表达式，标识变量的具体表达式，不能为空
     */
    private String variableExpression;
    /**
     * 执行顺序，默认为1
     */
    private Integer executeOrder;

}
