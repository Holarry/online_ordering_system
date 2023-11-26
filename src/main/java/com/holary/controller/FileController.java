package com.holary.controller;

import com.holary.util.TencentCosUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author: Holary
 * @Date: 2023/11/26 19:50
 * @Description: FileController
 */
@RestController
@RequestMapping("/file")
public class FileController {

    @RequestMapping("/upload")
    public Map<String, Object> upload(MultipartFile file) {
        HashMap<String, Object> map = new HashMap<>();
        String url = null;
        try {
            url = TencentCosUtil.uploadFile(file);
        } catch (IOException e) {
            map.put("code", -1);
            map.put("message", e.getMessage());
        }
        map.put("code", 200);
        map.put("url", url);
        return map;
    }
}
