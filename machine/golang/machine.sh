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
	filePathSource=$1 #
    folderName=$2
	filePath=($@)

	for ((i = 2; i < $#; i++))
	do
		go run $filePathSource < ${filePath[$i]} > result/golang/$folderName/resultCase$((i - 1)).out
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
	
	for ((i = 2; i < $#; i++))
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
	echo "result: $count/$quantityTest, score: $((count/quantityTest*100))"
}

submit() {
	quantityTest=$1
	fileSubmit=$2
    folderNameResult=$3
    folderNameOutput=$4

	arr[0]=$fileSubmit

	for ((i = 1; i <= $1; i++))
	do
		arr[$i]=input/golang/$folderName/case$i.inp
	done
	output ${arr[@]} $folderNameOutput
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
            sub $2 $3 $4 $5
            newFolder $folderName
            ;;
        2)
            res $2 $3 $4 $5
            ;;
    esac

}

main $1 $2 $3 $4 $5