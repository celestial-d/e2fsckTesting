import operator as op
import os
import sys
import json
####################################################
#operation extract
###################################################
def Operation_extract_line(line):
    operation_set=[]
    for line1 in line:
        #line1=line1.replace(" ","")
        if "=" in line1: # first situation, instuction contain "="
            tmp=line1.split("=",2)
            operation_setx=tmp[1].split(" ",2)
            operation=operation_setx[1]
            #print(operation)
        else:#second situation, instruction does not contain "="
            tmp=line1.split("%")[0].split(" ")
            if len(tmp) >= 2:
                operation=tmp[2]
                #print(operation)
        if operation not in operation_set:
           operation_set.append(operation)
    return operation_set

def Operation_extract(files,json_dic):
    #for loop to get operations
    tmp_dic={}
    for file_name in files:
        operation_set=Operation_extract_line(files[file_name])
        tmp_dic=json_dic[file_name]
        tmp_dic["operation"]=operation_set
    return json_dic

####################################################
#value Type
####################################################
#sgt":"signed >","slt":"signed <","sge":"signed >=","sle":"signed <=",
 #              "ne":"!=","eq":"=",
  #             "ult":"unsigned <","ugt":"unsigned >","uge":"unsigned >=","ule":"unsitgned <="
def value_type_identify(line):
    for line1 in line:
        if "slt" in line1 or "sge" in line1 or "sle" in line1 or "sgt" in line1:
            result="signed"
            return result
        if "ult" in line1 or "uge" in line1 or "ugt" in line1 or "ule" in line1:
            result="unsigned"
            return result

def value_type_extract(files,json_dic):
    for file_name in files:
        tmp=json_dic[file_name]
        tmp["value_type"]=value_type_identify(files[file_name])
    return json_dic
####################################################
#trace compare
####################################################
def dic_revise(json_dic,file_name1,file_name2):  #update json_dic dependency
    #update trace1 dependency

    tmp_dic1=json_dic[file_name1].copy()
    # revsie json "dependency"
    tmp1_arr=tmp_dic1["dependency"].copy()
    tmp1_arr.append(file_name2)
    tmp_dic1["dependency"]=tmp1_arr
    json_dic[file_name1]=tmp_dic1
    #update trace2 dependency
    tmp_dic2 = json_dic[file_name2].copy()
    #revise json dependency
    tmp2_arr=tmp_dic2["dependency"].copy()
    tmp2_arr.append(file_name1)
    tmp_dic2["dependency"]=tmp2_arr
    json_dic[file_name2]=tmp_dic2
    return json_dic

def Trace_compare(file1,file2,name1,name2):# compare the trace and print the common line
    common_line_file=open('common_line.txt','a+')
    mark=0 #use for check whether they have common line or not
    for line1 in file1:
        for line2 in file2:
            line1 = line1.replace(" ","")  # delate space
            line2 = line2.replace(" ","")
            if line1 == line2:
                if not len(line1):
                    continue
                else:
                    common_line_file.write(name1+","+name2+":\n")
                    print(name1+","+name2)
                    common_line_file.write(line1+"\n")
                    print(line1)
                    mark=1
                #print(line1)
                #print("\n")
    common_line_file.close()
    if mark==0:
        return False
    if mark==1:
        return True

def Trace_whole_compare(files,json_dic):#comapre all files and fill out the dependency
    file_arr=[]
    file_name_arr=[]
    for file_name in files:
        file_arr.append(file_content_dic[file_name])
        file_name_arr.append(file_name)
    for i in range(len(file_arr)-1):
        for j in range(i+1,len(file_arr)):
            result=Trace_compare(file_arr[i],file_arr[j],file_name_arr[i],file_name_arr[j])
            if result:
                json_dic=dic_revise(json_dic,file_name_arr[i],file_name_arr[j])
    return json_dic

#######################################################
#icmp constraint extract
#######################################################
contraint_dic={"sgt":"signed >","slt":"signed <","sge":"signed >=","sle":"signed <=",
               "ne":"!=","eq":"=",
               "ult":"unsigned <","ugt":"unsigned >","uge":"unsigned >=","ule":"unsitgned <="}

def icmp_Union(icmp_arr):
    return

def icmp_intersection(icmp_arr):
    return

def icmp_constrint(lines):
    count = 0  # use for judge the line number for icmp
    output_count=3 #use for print first three value
    feature_arr=[]
    tmp=[]
    for line1 in lines:
        #line1=line1.replace(" ","")#delate space
        if "icmp" in line1:  # if is icmp line, need to check next line
            value = line1.split(",")[1].split(" ")[1]
            operation = line1.split("=")[1].split(" ")[2]
            count = 1
        elif count == 1:  # next line operation, print differnt thing based on key words
            extra_info = ""
            if "com_err" in line1:
                extra_info = "com_err"
            if "fprintf" in line1:
                extra_info = "fprintf"
            if extra_info == None: # add new requirements: delate value==0 or contain %
                #print(operation, value)
                if value!="0" and "%" not in value and output_count>0:
                    feature_arr.append(operation+" "+value)
                    output_count=output_count-1
                #feature_arr.append(tmp)
                #tmp=[]
            else:
                #print(operation, value, extra_info)
                if value != "0"  and  "%" not in value and output_count>0:# add new requirements: delate value==0 or contain %
                    feature_arr.append(operation+" "+value+" "+extra_info)
                    output_count = output_count - 1
                #feature_arr.append(tmp)
                #tmp=[]
            count = 0
        if line1 == lines[-1] and count == 1:  # if this is the last line, output the result directly
            #print(operation, value)
            if value != "0"  and  "%" not in value and output_count>0:# add new requirements: delate value==0 or contain %
                feature_arr.append(operation+" "+value)
                output_count = output_count - 1
            #feature_arr.append(tmp)
            #tmp=[]
    return feature_arr



def whole_constrint(file_content_dic,json_dic):# get whole constrint for each file and add to dictionary
    for file_name in file_content_dic:
        file_content=file_content_dic[file_name]
        feature_icmp=icmp_constrint(file_content)
        #revsie json "value"
        tmp_dic=json_dic[file_name]
        tmp_dic["value"]=feature_icmp
    return json_dic


####################################################################
#file initialization
####################################################################

default_dic={"id": 0,
		# "arg": "-b",
		"value_type": "unknown",
		"value": None, # (2^0 to 2^2)*1024
		"dependency":[],
        "operation":[]}

def read_files(argv):#get default dic and file lines
    file={}
    json_dic = {}
    for i in range(1,len(sys.argv)):
        tmp_dic=default_dic.copy()
        tmp_dic["id"]=i
        json_dic[sys.argv[i]]=tmp_dic
        with open(sys.argv[i], "r") as c:
            file[sys.argv[i]] = c.read().splitlines()
    return file,json_dic

###########################################################
#main run
###########################################################
print(sys.argv)
print(len(sys.argv))
if os.path.exists('common_line.txt'): # if commen line file exist, delate is
    os.remove('common_line.txt')
file_content_dic,json_dic=read_files(sys.argv) #get default dic and file lines

json_dic=Operation_extract(file_content_dic,json_dic)

json_dic=value_type_extract(file_content_dic,json_dic)

json_dic=whole_constrint(file_content_dic,json_dic) #revise icmp contraint

if len(sys.argv) > 2:
    json_dic=Trace_whole_compare(file_content_dic,json_dic) ## extract dependency and revise dependency

with open('result.json', 'w') as f:             #json file write
	json.dump(json_dic, f, ensure_ascii=False, indent=4)

