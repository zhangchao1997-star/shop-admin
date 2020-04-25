package com.utils;

import com.beans.PageInfo;

public class PageUtil {
    public static PageInfo getPageInfo(int pageSize,int rowCount,int pageIndex){
        PageInfo pageInfo = new PageInfo();
        pageInfo.setPageSize(pageSize==0?10:pageSize);
        pageInfo.setRowCount(rowCount);
        pageInfo.setPageIndex(pageIndex);

        pageInfo.setPageCount((rowCount+pageSize-1)/pageSize);
        pageInfo.setBeginRow(pageInfo.getPageSize()*(pageIndex-1));
        pageInfo.setHasNext(pageIndex<pageInfo.getPageCount());
        pageInfo.setHasPre(pageIndex!=1);
        return pageInfo;
    }
}
