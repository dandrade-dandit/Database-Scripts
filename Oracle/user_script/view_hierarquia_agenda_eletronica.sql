create or replace view hierarquia_agenda_eletronica as 
(
select uor_codigo,
       uor_nome,
       uor_uor_codigo,
       emp_qfu_fun_codigo,
       fun_nome,
       emp_nome,
       ordem_funcao.ordem
from   unidades_organizacionais uor,
       cadastros cad,
       cargos_confianca fun,
       (select '5' ordem, 924 fun_codigo from dual 
        union 
       select '5' ordem, 916 fun_codigo from dual 
        union 
       select '5' ordem, 894 fun_codigo from dual 
        union 
       select '5' ordem, 899 fun_codigo from dual 
        union 
       select '5' ordem, 940 fun_codigo from dual 
        union 
       select '5' ordem, 937 fun_codigo from dual 
        union 
       select '5' ordem, 897 fun_codigo from dual 
        union 
       select '5' ordem, 898 fun_codigo from dual 
        union 
       select '5' ordem, 902 fun_codigo from dual 
        union 
       select '5' ordem, 903 fun_codigo from dual 
        union 
       select '5' ordem, 947 fun_codigo from dual 
        union 
       select '5' ordem, 925 fun_codigo from dual 
        union 
       select '5' ordem, 926 fun_codigo from dual 
        union 
       select '5' ordem, 928 fun_codigo from dual 
        union 
       select '5' ordem, 929 fun_codigo from dual 
        union 
       select '5' ordem, 890 fun_codigo from dual 
        union 
       select '5' ordem, 885 fun_codigo from dual 
        union 
       select '2' ordem, 685 fun_codigo from dual 
        union 
       select '2' ordem, 680 fun_codigo from dual 
        union 
       select '2' ordem, 688 fun_codigo from dual 
        union 
       select '2' ordem, 686 fun_codigo from dual 
        union 
       select '2' ordem, 687 fun_codigo from dual 
        union 
       select '6' ordem, 907 fun_codigo from dual 
        union 
       select '6' ordem, 913 fun_codigo from dual 
        union 
       select '6' ordem, 914 fun_codigo from dual 
        union 
       select '6' ordem, 932 fun_codigo from dual 
        union 
       select '6' ordem, 908 fun_codigo from dual 
        union 
       select '6' ordem, 931 fun_codigo from dual 
        union 
       select '6' ordem, 909 fun_codigo from dual 
        union 
       select '6' ordem, 933 fun_codigo from dual 
        union 
       select '6' ordem, 934 fun_codigo from dual 
        union 
       select '6' ordem, 905 fun_codigo from dual 
        union 
       select '6' ordem, 936 fun_codigo from dual 
        union 
       select '4' ordem, 886 fun_codigo from dual 
        union 
       select '4' ordem, 891 fun_codigo from dual 
        union 
       select '4' ordem, 923 fun_codigo from dual 
        union 
       select '3' ordem, 900 fun_codigo from dual 
        union 
       select '4' ordem, 946 fun_codigo from dual 
        union 
       select '4' ordem, 880 fun_codigo from dual 
        union 
       select '4' ordem, 935 fun_codigo from dual 
        union 
       select '4' ordem, 878 fun_codigo from dual 
        union 
       select '4' ordem, 938 fun_codigo from dual 
        union 
       select '1' ordem, 689 fun_codigo from dual 
        union 
       select '3' ordem, 877 fun_codigo from dual 
        union 
       select '3' ordem, 883 fun_codigo from dual 
        union 
       select '3' ordem, 884 fun_codigo from dual 
        union 
       select '3' ordem, 889 fun_codigo from dual 
        union 
       select '3' ordem, 949 fun_codigo from dual 
        union 
       select '3' ordem, 945 fun_codigo from dual 
        union 
       select '3' ordem, 918 fun_codigo from dual) ordem_funcao
where uor.uor_codigo = cad.emp_uor_codigo_lotacao
and cad.emp_qfu_fun_codigo = fun.fun_codigo
and uor_data_extincao is null
and emp_qfu_fun_codigo = ordem_funcao.fun_codigo (+)
and emp_status != 2
)
/
