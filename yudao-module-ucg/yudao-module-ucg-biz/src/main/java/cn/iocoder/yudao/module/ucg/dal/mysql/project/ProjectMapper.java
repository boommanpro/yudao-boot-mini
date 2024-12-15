package cn.iocoder.yudao.module.ucg.dal.mysql.project;

import java.util.*;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.mybatis.core.query.LambdaQueryWrapperX;
import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectDO;
import org.apache.ibatis.annotations.Mapper;
import cn.iocoder.yudao.module.ucg.controller.admin.project.vo.*;

/**
 * 存储项目的基本信息 Mapper
 *
 * @author 管理员
 */
@Mapper
public interface ProjectMapper extends BaseMapperX<ProjectDO> {

    default PageResult<ProjectDO> selectPage(ProjectPageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<ProjectDO>()
                .likeIfPresent(ProjectDO::getProjectName, reqVO.getProjectName())
                .eqIfPresent(ProjectDO::getProjectDescription, reqVO.getProjectDescription())
                .eqIfPresent(ProjectDO::getEnableStatus, reqVO.getEnableStatus())
                .betweenIfPresent(ProjectDO::getCreateTime, reqVO.getCreateTime())
                .orderByDesc(ProjectDO::getId));
    }

}