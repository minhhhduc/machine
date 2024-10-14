#!/bin/bash

newFolder() {
    folderName=$1
    mkdir output/golang/$folderName
    mkdir result/golang/$folderName
}

removeFolder() {
    folderName=$1
    rm -rf output/golang/$folderName
    # rm -rf result/golang/$folderName
}


result() {
	quantityTest=$1
	filePathSource=$2
    folderNameResult=$3
    folderNameOutput=$4

	for ((i = 1; i <= quantityTest; i++))
	do
		go run $filePathSource < input/golang/$folderNameResult/case$i.inp > result/golang/$folderName/resultCase$((i - 1)).out
	done
}

resultNoInput() {
    filePathSource=$1 #
    folderName=$2
	go run $filePathSource > result/golang/$folderName/resultCase1.out
}

# resultInputByFile() {
#     echo ""
# }

output() {
	filePathSubmit=$1 #~/Desktop/submit/python/main.py
    folderName=$2
	filePath=($@)
	
	for ((i = 2; i <= $#; i++))
	do
		go run $filePathSubmit < ${filePath[$i]} > output/golang/$folderName/case$((i - 1)).out
	done
} 

outputNoInput() {
    filePathSubmit=$1 #~/Desktop/submit/python/main.py
    folderName=$2
    go run $filePathSubmit > output/golang/$folderName/case1.out
}

outSubmit() {
	count=0
	quantityTest=$1
    folderNameResult=$2
    folderNameOutput=$3

	for ((i = 1; i <= $quantityTest; i ++)) 
	do
		result=`cat result/golang/$folderNameResult/resultCase$i.out`
		output=`cat output/golang/$folderNameOutput/case$i.out`
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
    arr[1]=$folderResult

	for ((i = 2; i <= $1 + 1; i++))
	do
		arr[$i]=input/golang/$folderNameResult/case$((i - 1)).inp
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
    esac   
}

main() {
    action=$1
    folderName=$5
    newFolder $folderName
    case $action
    in
        1)
            mkdir output/golang/$folderName
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