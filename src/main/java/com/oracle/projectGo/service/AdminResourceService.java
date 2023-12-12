package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.AdminResourceDao;
import com.oracle.projectGo.dto.EducationalResources;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminResourceService {
    private final AdminResourceDao adminResourceDao;

    public int educationUpload(EducationalResources educationalResources) {
        return adminResourceDao.educationUpload(educationalResources);
    }

    public List<EducationalResources> listEdu() {
        return adminResourceDao.listEdu();
    }
}
