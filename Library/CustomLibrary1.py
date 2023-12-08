import string
import sys
from robot.api import ExecutionResult, ResultVisitor

def compare_string_has(main_string,sub1,sub2):
    main_string_lower = main_string.lower()
    sub1_lower = sub1.lower()
    sub2_lower = sub2.lower()
    if sub1_lower in main_string_lower or sub2_lower in main_string_lower:
        return "PASS"   
    else:
       return "FAIL"

    
