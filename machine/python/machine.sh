#!/bin/bash

newFolder() {
    folderName=$1
    mkdir output/python/$folderName
    mkdir result/python/$folderName
}

removeFolder() {
    folderName=$1
    rm -rf output/python/$folderName
    # rm -rf result/python/$folderName
}


result() {
	quantityTest=$1
	filePathSource=$2
    folderNameResult=$3
    folderNameOutput=$4

	for ((i = 1; i <= quantityTest; i++))
	do
		python $filePathSource < input/python/$folderNameResult/case$i.inp > result/python/$folderNameOutput/resultCase$i.out
	done
}

resultNoInput() {
    filePathSource=$1 #
    folderName=$2
	python $filePathSource > result/python/$folderName/resultCase1.out
}

resultBycommandLineArgrument() {
    filePathSource=$1 #
    folderName=$2
    filePath=$3
    while read line
    do
        python $filePathSource $line > result/python/$folderName/resultCase1.out
    done < $filePath
}

# resultInputByFile() {
#     echo ""
# }

output() {
	filePathSubmit=$1 #~/Desktop/submit/python/main.py
    folderName=$2
	filePath=($@)


	for ((i = 3; i <= $#; i++))
	do
		python $filePathSubmit < ${filePath[$((i - 1))]} > output/python/$folderName/case$((i - 2)).out
	done
} 

outputNoInput() {
    filePathSubmit=$1 #~/Desktop/submit/python/main.py
    folderName=$2
    python $filePathSubmit > output/python/$folderName/case1.out
}

outputBycommandLineArgrument() {
    filePathSubmit=$1 #~/Desktop/submit/python/main.py
    folderName=$2
    filePath=$3
    while read line
    do
        python $filePathSubmit $line > output/python/$folderName/case1.out
    done < $filePath
}

outSubmit() {
	count=0
	quantityTest=$1
    folderNameResult=$2
    folderNameOutput=$3

	for ((i = 1; i <= $quantityTest; i ++)) 
	do
		result=`cat result/python/$folderNameResult/resultCase$i.out`
		output=`cat output/python/$folderNameOutput/case$i.out`
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
		arr[$i]=input/python/$folderName/case$((i - 1)).inp
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
            submitBycommandLineArgrument $quantityTest $filePath $folderResult input/python/$folderResult/case1.inp
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
            resultBycommandLineArgrument $filePath $folderResult input/python/$folderResult/case1.inp
            ;;
    esac   
}

main() {
    action=$1
    folderName=$5
    case $action
    in
        1)
            # newFolder $folderName
            mkdir output/python/$folderName    
            sub $2 $3 $4 $5
            removeFolder $folderName
            ;;
        2)
            newFolder $folderName
            res $2 $3 $4 $5
            ;;
    esac

}

main $1 $2 $3 $4 $5