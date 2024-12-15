package cn.iocoder.yudao.module.ucg.service.codetemplate;

import cn.iocoder.yudao.framework.mybatis.core.query.LambdaQueryWrapperX;
import cn.iocoder.yudao.module.ucg.enums.ErrorCodeConstants;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import cn.iocoder.yudao.module.ucg.controller.admin.codetemplate.vo.*;
import cn.iocoder.yudao.module.ucg.dal.dataobject.codetemplate.CodeTemplateDO;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.pojo.PageParam;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;

import cn.iocoder.yudao.module.ucg.dal.mysql.codetemplate.CodeTemplateMapper;

import static cn.iocoder.yudao.framework.common.exception.util.ServiceExceptionUtil.exception;

/**
 * 存储代码模板的基本信息 Service 实现类
 *
 * @author 管理员
 */
@Service
@Validated
public class CodeTemplateServiceImpl implements CodeTemplateService {

    @Resource
    private CodeTemplateMapper codeTemplateMapper;

    @Override
    public Long createCodeTemplate(CodeTemplateSaveReqVO createReqVO) {
        // 插入
        CodeTemplateDO codeTemplate = BeanUtils.toBean(createReqVO, CodeTemplateDO.class);
        codeTemplateMapper.insert(codeTemplate);
        // 返回
        return codeTemplate.getId();
    }

    @Override
    public void updateCodeTemplate(CodeTemplateSaveReqVO updateReqVO) {
        // 校验存在
        validateCodeTemplateExists(updateReqVO.getId());
        // 更新
        CodeTemplateDO updateObj = BeanUtils.toBean(updateReqVO, CodeTemplateDO.class);
        codeTemplateMapper.updateById(updateObj);
    }

    @Override
    public void deleteCodeTemplate(Long id) {
        // 校验存在
        validateCodeTemplateExists(id);
        // 删除
        codeTemplateMapper.deleteById(id);
    }

    private void validateCodeTemplateExists(Long id) {
        if (codeTemplateMapper.selectById(id) == null) {
            throw exception(ErrorCodeConstants.COMMON_EXCEPTION);
        }
    }

    @Override
    public CodeTemplateDO getCodeTemplate(Long id) {
        return codeTemplateMapper.selectById(id);
    }

    @Override
    public PageResult<CodeTemplateDO> getCodeTemplatePage(CodeTemplatePageReqVO pageReqVO) {
        return codeTemplateMapper.selectPage(pageReqVO);
    }

    @Override
    public List<CodeTemplateDO> loadCodeTemplateByFrontType(String frontType) {
        return codeTemplateMapper.selectByFrontType(1L, frontType);
    }

}
