package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.workbench.base.Clue;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.base.ClueRemark;
import com.github.pagehelper.PageInfo;

public interface ClueService {
    ResultVo addAndUpdateClue(Clue clue, User user);

    PageInfo selectClues(Integer page, Integer pageSize,Clue clue);

    Clue editClue(String id);

    ResultVo deleteClue(String ids);

    Clue selectClue(String id);

    ResultVo delete(String id);

    ResultVo saveRemark(ClueRemark clueRemark, User user);

    ResultVo updateClueRemark(ClueRemark clueRemark, User user);

    ResultVo deleteClueRemark(String id);

}
