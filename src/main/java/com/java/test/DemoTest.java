package com.java.test;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.google.common.annotations.VisibleForTesting;
import org.junit.Test;

/**
 * description：
 * author：丁鹏
 * date：10:43
 */
public class DemoTest {

    @Test
    public void test1(){
        System.out.println("-20".matches("[1-9]\\d*.\\d*|0.\\d*[1-9]\\d*|0?.0+|0"));

    }

    @Test
    public void test2(){
        System.out.println(SecureUtil.md5("123456"));
    }

}
