package cn.iocoder.yudao.module.ucg.dal.dataobject.project;

import lombok.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.*;
import cn.iocoder.yudao.framework.mybatis.core.dataobject.BaseDO;

/**
 * 存储项目的基本信息 DO
 *
 * @author 管理员
 */
@TableName("ucg_project")
@KeySequence("ucg_project_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProjectDO extends BaseDO {

    /**
     * 编号，自增，唯一标识一个项目
     */
    @TableId
    private Long id;
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

}