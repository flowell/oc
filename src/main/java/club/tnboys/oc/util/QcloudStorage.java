package club.tnboys.oc.util;

import com.qcloud.cos.COSClient;
import com.qcloud.cos.ClientConfig;
import com.qcloud.cos.auth.BasicCOSCredentials;
import com.qcloud.cos.auth.COSCredentials;
import com.qcloud.cos.http.HttpMethodName;
import com.qcloud.cos.model.*;
import com.qcloud.cos.region.Region;
import org.springframework.beans.factory.annotation.Value;

import java.net.URL;
import java.util.Date;

public class QcloudStorage {
    @Value("${qcloud.secretId}")
    private String secretId;
    @Value("$qcloud.secretKey")
    private String secretKey;
    @Value("${qcloud.region}")
    private String region;
    @Value("${qcloud.appid}")
    private String appid;
    @Value("${qcloud.bucket}")
    private String bucket;
    private String bucketName;
    private COSClient cosClient;

    void init() {
        // 1 初始化用户身份信息(secretId, secretKey)
        COSCredentials cred = new BasicCOSCredentials(secretId, secretKey);
        // 2 设置bucket的区域, COS地域的简称请参照 https://cloud.tencent.com/document/product/436/6224
        ClientConfig clientConfig = new ClientConfig(new Region(region));
        // 3 生成cos客户端
        cosClient = new COSClient(cred, clientConfig);
        // bucket的命名规则为{name}-{appid} ，此处填写的存储桶名称必须为此格式
        bucketName = bucket + "-" + appid;
    }

    String getDownloadUrl(String key) {
        // 生成一个下载链接
        // bucket 的命名规则为{name}-{appid} ，此处填写的存储桶名称必须为此格式
        GeneratePresignedUrlRequest req =
                new GeneratePresignedUrlRequest(bucketName, key, HttpMethodName.GET);
        // 设置签名过期时间(可选), 若未进行设置, 则默认使用 ClientConfig 中的签名过期时间(5分钟)
        // 这里设置签名在半个小时后过期
        Date expirationDate = new Date(System.currentTimeMillis() + 30L * 60L * 1000L);
        req.setExpiration(expirationDate);
        URL downloadUrl = cosClient.generatePresignedUrl(req);
        String downloadUrlStr = downloadUrl.toString();
        return downloadUrlStr;
    }

    String getUploadUrl(String key) {
        // 设置签名过期时间(可选), 若未进行设置, 则默认使用 ClientConfig 中的签名过期时间(5分钟)
        // 这里设置签名在半个小时后过期
        Date expirationTime = new Date(System.currentTimeMillis() + 30L * 60L * 1000L);
        URL url = cosClient.generatePresignedUrl(bucketName, key, expirationTime, HttpMethodName.PUT);
        String uploadUrlStr = url.toString();
        return uploadUrlStr;
    }

    void delete(String key) {
        // 指定要删除的 bucket 和路径
        cosClient.deleteObject(bucketName, key);
    }

    void close() {
        // 关闭客户端(关闭后台线程)
        cosClient.shutdown();
    }


}
