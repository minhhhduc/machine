#open gitbash on shell script
submit() {
    #filePath=source/python/demo/main.py
    testType=0
    option=0
    while [ $option -ne 1 ] && [ $option -ne 2 ]
    do
        read -p "[1]Submit [2]Result: " option
        echo 
    done 

    while [ $testType -lt 1 ] || [ $testType -gt 3 ]
    do 
    read -p "[1]:no input [2]:input: [3]:comand line args: " testType  # 1:no input, 2:input
    echo
    done
    read -p "Input file name: " filePath
    echo
    read -p "Input folder name [name exam]: " folderName
    echo
    fileType=`echo $filePath | cut -d '.' -f 2`
    quantityTest=0

    if [ $testType -eq 2 ]
    then
        read -p "Input quantity test: " quantityTest
        echo
    fi

    case $fileType
    in
        "py")
            bash machine/python/machine.sh $option source/python/$folderName/$filePath $testType $quantityTest $folderName
            ;;
        "c")
            bash machine/c-cpp/c/machine.sh $option source/c-cpp/c/$folderName/$filePath $testType $quantityTest $folderName
            ;;
        "cpp")
            bash machine/c-cpp/cpp/machine.sh $option source/c-cpp/cpp/$folderName/$filePath $testType $quantityTest $folderName
            ;;
        "java") 
            bash machine/java/machine.sh $option source/java/$folderName/$filePath $testType $quantityTest $folderName
            ;;
        "sh")
            bash machine/shellscript/machine.sh $option source/shellscript/$folderName/$filePath $testType $quantityTest $folderName
            ;;
        "pas")
            bash machine/pascal/machine.sh $option source/pascal/$folderName/$filePath $testType $quantityTest $folderName
            ;;
        "go")
            bash macine/golang/machine.sh $option source/golang/$folderName/$filePath $testType $quantityTest $folderName
            ;;
    esac
}

main() {
    submit
}
main