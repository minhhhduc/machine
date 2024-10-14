#!/bin/bash

newFolder() {
    folderName=$1
    mkdir output/c-cpp/c/$folderName
    mkdir result/c-cpp/c/$folderName
}

removeFolder() {
    folderName=$1
    rm -rf output/c-cpp/c/$folderName
    # rm -rf result/c-cpp/c/$folderName
}

result() {
	quantityTest=$1 
    filePathSource=$2
    folderNameResult=$3
    namePath=`echo "$filePathSource" | cut -d '.' -f 1`
    gcc $filePathSource -o $namePath # compile file c

	for ((i = 1; i <= quantityTest; i++))
	do
        ./$namePath < input/c-cpp/c/$folderNameResult/case$i.inp > result/c-cpp/c/$folderName/resultCase$i.out
	done
}

resultNoInput() {
    filePathSource=$1 #
    folderName=$2
    namePath=`echo "$filePathSource" | cut -d '.' -f 1`
    gcc $filePathSource -o $namePath # compile file c
	./$namePath > result/c-cpp/c/$folderName/resultCase1.out
}

resultBycommandLineArgrument() {
    filePathSource=$1 #
    folderName=$2
    namePath=`echo "$filePathSource" | cut -d '.' -f 1`
    filePath=$3
    gcc $filePathSource -o $namePath
    while read line
    do
        ./$namePath $line > result/c-cpp/c/$folderName/resultCase1.out
    done < $filePath
}

# resultInputByFile() {
#     echo ""
# }

output() {
	filePathSubmit=$1 
    folderName=$2
	filePath=($@)
    namePath=`echo "$filePathSubmit" | cut -d '.' -f 1`
    gcc $filePathSubmit -o $namePath # compile file c 
	
    for ((i = 3; i <= $#; i++))
	do
		./$namePath < ${filePath[$((i - 1))]} > output/c-cpp/c/$folderName/case$((i - 2)).out
	done
} 

outputNoInput() {
    filePathSubmit=$1 #~/Desktop/submit/c-cpp/c/main.py
    folderName=$2
    namePath=`echo "$filePathSubmit" | cut -d '.' -f 1`
    gcc $filePathSubmit -o $namePath # compile file c 
    ./$namePath > output/c-cpp/c/$folderName/case1.out
}

outputBycommandLineArgrument() {
    filePathSubmit=$1 #~/Desktop/submit/python/main.py
    folderName=$2
    namePath=`echo "$filePathSubmit" | cut -d '.' -f 1`
    filePath=$3
    gcc $filePathSubmit -o $namePath # compile file c 
    while read line
    do
        ./$namePath $line > output/c-cpp/c/$folderName/case1.out
    done < $filePath
}

outSubmit() {
	count=0
	quantityTest=$1
    folderNameResult=$2
    folderNameOutput=$3

	for ((i = 1; i <= $quantityTest; i ++)) 
	do
		result=`cat result/c-cpp/c/$folderNameResult/resultCase$i.out`
		output=`cat output/c-cpp/c/$folderNameOutput/case$i.out`
        # result="$result"
        # output="$output"
		if [[ $result == $output ]]
		then
			echo "Case $i: AC"
			((count ++)) 
		else
			echo "Case $i: WA"
		fi
	done
	echo "result: $count/$quantityTest, score: $((100*count/quantityTest))"
}

submit() {
	quantityTest=$1
	fileSubmit=$2
    folderNameResult=$3
    folderNameOutput=$4

	arr[0]=$fileSubmit
    arr[1]=$folderNameResult
    
	for ((i = 2; i <= $1 + 1; i++))
	do
		arr[$i]=input/c-cpp/c/$folderNameResult/case$((i - 1)).inp
	done
	output ${arr[@]}
	outSubmit $quantityTest $folderNameResult $folderNameOutput
}

submitNoInput() {
	fileSubmit=$1
    folderNameResult=$2
    folderNameOutput=$3

    outputNoInput $fileSubmit $folderNameOutput $quantityTest
	outSubmit 1 $folderNameResult $folderNameOutput
}

submitBycommandLineArgrument() {
    quantityTest=$1
    fileSubmit=$2
    folderNameResult=$3
    folderNameOutput=$folderNameResult
    filePath=$4
    outputBycommandLineArgrument $fileSubmit $folderNameOutput $filePath
    outSubmit 1 $folderNameResult $folderNameOutput
}

sub() {
    filePath=$1
	quantityTest=$3
    folderOut=$4
    folderResult=$folderOut
	# submit $quantityTest $filePath demo demo
    option=$2 
    case $option
    in
        1)
            submitNoInput $filePath $folderResult $folderOut
            ;;
        2)
            submit $quantityTest $filePath $folderResult $folderOut
            ;;
         3)
            submitBycommandLineArgrument $quantityTest $filePath $folderResult input/c-cpp/c/$folderResult/case1.inp
            ;;
    esac    
}

res() {
    filePath=$1
	quantityTest=$3
    folderOut=$4
    folderResult=$folderOut
	# submit $quantityTest $filePath demo demo
    option=$2 
    case $option
    in
        1)
            resultNoInput $filePath $folderResult $folderOut
            ;;
        2)
            result $quantityTest $filePath $folderResult $folderOut
            ;;
        3)
            resultBycommandLineArgrument $filePath $folderResult input/c-cpp/c/$folderResult/case1.inp
            ;;
    esac   
}

main() {
    filePathSource=$2
    action=$1
    case $action
    in
        1)
            mkdir output/c-cpp/c/$5
            sub $2 $3 $4 $5
            removeFolder $5
            ;;
        2)
            newFolder $5
            res $2 $3 $4 $5
            ;;
    esac
    
}

main $1 $2 $3 $4 $5