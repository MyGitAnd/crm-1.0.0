package com.bjpowernode.crm.base.utils;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUploadUtil {


    public static ResultVo FileUpload(MultipartFile img, HttpServletRequest request){
        ResultVo resultVo = new ResultVo();
        try {
            String path = request.getSession().getServletContext().getRealPath("/upload");
            //文件类
            File file = new File(path);
            //查看有没有这个目录，没有的话创建出来
            if (!file.exists()){
                file.mkdirs();
            }
            //获取长传的文件名
            String filename = img.getOriginalFilename();
            //防止重名后覆盖掉
            filename = UUIDUtil.getUUID()+System.currentTimeMillis()+filename;
            //防止文件大于2MB
            veiryfyMaxSize(img.getSize());
            //查看后缀名是否是允许的的后缀名
            veiryfysuffix(img.getOriginalFilename());

            img.transferTo(new File(path+File.separator+filename));
            resultVo.setOk(true);
            resultVo.setMessage("上传头像成功！");
            //获取项目名称
            String Path = request.getContextPath()+File.separator+"upload"+File.separator+filename;
            resultVo.setT(Path);
        } catch (CrmException e) {
           resultVo.setMessage(e.getMessage());
        } catch (IOException e) {
           resultVo.setMessage("其他错误....");
        }
        return resultVo;
    }
    //查看后缀名是否是允许的的后缀名
    private static void veiryfysuffix(String originalFilename) {
        if (!("png,jpg,bmp,gif,").contains(originalFilename.substring(originalFilename.lastIndexOf(".")+1))){
            throw new CrmException(CrmEnum.USER_UPLOAD_SUFFIX);
        }
    }

    //判断文件大小
    private static void veiryfyMaxSize(long size) {
        if (size > 2 * 1024 * 1024){
            throw new CrmException(CrmEnum.USER_UPLOAD_MAXSIZE);
        }
    }
}
