package com.holary.util;

import com.holary.config.TencentCosConfig;
import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.http.HttpProtocol;
import com.qcloud.cos.model.ObjectMetadata;
import com.qcloud.cos.model.PutObjectRequest;
import com.qcloud.cos.region.Region;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;

/**
 * @Author: Holary
 * @Date: 2023/11/26 20:08
 * @Description: 腾讯云COS工具类
 */
public class TencentCosUtil {

    public static String uploadFile(MultipartFile file) throws IOException {
        // 1 初始化用户身份信息(secretId, secretKey)
        COSCredentials cred = new BasicCOSCredentials(TencentCosConfig.SECRETID, TencentCosConfig.SECRETKEY);
        // 2 设置bucket的地域
        ClientConfig clientConfig = new ClientConfig(new Region(TencentCosConfig.REGION));
        // 从 5.6.54 版本开始，默认使用了 https
        clientConfig.setHttpProtocol(HttpProtocol.https);
        // 3 生成cos客户端
        COSClient cosClient = new COSClient(cred, clientConfig);

        // 指定文件上传到COS
        String originalFilename = file.getOriginalFilename();
        String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        String key = System.currentTimeMillis() + suffix;

        InputStream is = file.getInputStream();
        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentLength(is.available());
        PutObjectRequest putObjectRequest = new PutObjectRequest(TencentCosConfig.BUCKETNAME, key, is, objectMetadata);

        cosClient.putObject(putObjectRequest);

        return "https://" + TencentCosConfig.BUCKETNAME + "." + "cos" + "." + TencentCosConfig.REGION + ".myqcloud.com/" + key;
    }
}
