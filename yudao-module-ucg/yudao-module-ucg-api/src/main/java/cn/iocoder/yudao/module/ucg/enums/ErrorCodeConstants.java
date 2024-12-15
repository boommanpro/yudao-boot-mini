package cn.iocoder.yudao.module.ucg.enums;

import cn.iocoder.yudao.framework.common.exception.ErrorCode;

/**
 * Infra 错误码枚举类
 * <p>
 * infra 系统，使用 1-001-000-000 段
 */
public interface ErrorCodeConstants {


    // ========== 通用 2-001-000-001 ==========
    ErrorCode COMMON_EXCEPTION = new ErrorCode(2_001_000_001, "通用异常");

}
