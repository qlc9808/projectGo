package com.oracle.projectGo.dto;

import lombok.Data;

import java.util.List;

@Data
public class DistributionRequest {
    private List<Integer> studentIds;
    private List<Integer> homeworkIds;
}
