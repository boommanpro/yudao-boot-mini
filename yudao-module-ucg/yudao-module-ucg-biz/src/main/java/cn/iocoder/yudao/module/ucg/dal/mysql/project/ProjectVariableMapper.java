package cn.iocoder.yudao.module.ucg.dal.mysql.project;

import java.util.*;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.pojo.PageParam;
import cn.iocoder.yudao.framework.mybatis.core.query.LambdaQueryWrapperX;
import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectVariableDO;
import org.apache.ibatis.annotations.Mapper;

/**
 * 存储与项目相关的变量信息 Mapper
 *
 * @author 管理员
 */
@Mapper
public interface ProjectVariableMapper extends BaseMapperX<ProjectVariableDO> {

    default List<ProjectVariableDO> selectListByProjectId(Long projectId) {
        return selectList(ProjectVariableDO::getProjectId, projectId);
    }

    default int deleteByProjectId(Long projectId) {
        return delete(ProjectVariableDO::getProjectId, projectId);
    }

}
