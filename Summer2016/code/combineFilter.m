%%%%%%% Code for consolidating openCV cascade classifier training negative sample filenames %%%%%%%
load('filteredFiles.mat'); %% .mat file containing individual arrays with negative sample filenames 
C = cell(1707,1);
C(1:181,1) = C1(1,2:182);
C(182:331,1) = C2(1,2:151);
C(332:449,1) = C3(1,2:119);
C(450:465,1) = C4(1,2:17);
C(466:565,1) = C5(1,2:101);
C(566:657,1) = C6(1,2:93);
C(658:752,1) = C7(1,2:96);
C(753:847,1) = C8(1,2:96);
C(848:954,1) = C9(1,2:108);
C(955:1074,1) = C10(1,2:121);
C(1075:1186,1) = C11(1,2:113);
C(1187:1321,1) = C12(1,2:136);
C(1322:1495,1) = C13(1,2:175);
C(1496:1675,1) = C14(1,2:181);
C(1676:1707,1) = C15(1,2:33);
save('CFile','C'); %% save consolidated list of filenames 
