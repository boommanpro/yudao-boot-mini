package cn.iocoder.yudao.module.ucg.dal.mysql.codetemplate;

import java.util.*;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.mybatis.core.query.LambdaQueryWrapperX;
import cn.iocoder.yudao.framework.mybatis.core.mapper.BaseMapperX;
import cn.iocoder.yudao.module.ucg.dal.dataobject.codetemplate.CodeTemplateDO;
import org.apache.ibatis.annotations.Mapper;
import cn.iocoder.yudao.module.ucg.controller.admin.codetemplate.vo.*;
import org.apache.ibatis.annotations.Param;

/**
 * 存储代码模板的基本信息 Mapper
 *
 * @author 管理员
 */
@Mapper
public interface CodeTemplateMapper extends BaseMapperX<CodeTemplateDO> {

    default PageResult<CodeTemplateDO> selectPage(CodeTemplatePageReqVO reqVO) {
        return selectPage(reqVO, new LambdaQueryWrapperX<CodeTemplateDO>()
                .likeIfPresent(CodeTemplateDO::getTemplateName, reqVO.getTemplateName())
                .eqIfPresent(CodeTemplateDO::getProjectId, reqVO.getProjectId())
                .eqIfPresent(CodeTemplateDO::getTemplateDescription, reqVO.getTemplateDescription())
                .eqIfPresent(CodeTemplateDO::getTemplateType, reqVO.getTemplateType())
                .eqIfPresent(CodeTemplateDO::getTemplateTypeValue, reqVO.getTemplateTypeValue())
                .eqIfPresent(CodeTemplateDO::getFileType, reqVO.getFileType())
                .eqIfPresent(CodeTemplateDO::getFilePathExpression, reqVO.getFilePathExpression())
                .eqIfPresent(CodeTemplateDO::getOriginalPath, reqVO.getOriginalPath())
                .eqIfPresent(CodeTemplateDO::getTemplateContent, reqVO.getTemplateContent())
                .betweenIfPresent(CodeTemplateDO::getCreateTime, reqVO.getCreateTime())
                .orderByDesc(CodeTemplateDO::getId));
    }

    List<CodeTemplateDO> selectByFrontType(@Param("projectId") Long projectId, @Param("frontType") String frontType);

    default List<CodeTemplateDO> selectListByProjectId(Long projectId){
        return selectList(new LambdaQueryWrapperX<CodeTemplateDO>()
                .eq(CodeTemplateDO::getProjectId, projectId)
                .orderByDesc(CodeTemplateDO::getId));
    }
}
