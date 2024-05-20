#open gitbash on shell script
submit() {
    #filePath=source/python/demo/main.py
    testType=0
    option=0
    while [ $option -ne 1 ] && [ $option -ne 2 ]
    do
        read -p "[1]Submit [2]Result: " option
    done 

    while [ $testType -lt 1 ] || [ $testType -gt 3 ]
    do 
    read -p "[1]:no input [2]:input: [3]:comand line args" testType  # 1:no input, 2:input
    done
    read -p "Input file path: " filePath
    read -p "Input folder name [name exam]: " folderName
    fileType=`echo $filePath | cut -d '.' -f 2`
    quantityTest=0

    if [ $testType -eq 2 ]
    then
        read -p "Input quantity test: " quantityTest
    fi

    case $fileType
    in
        "py")
            bash machine/python/machine.sh $option $filePath $testType $quantityTest $folderName
            ;;
        "c")
            bash machine/c-cpp/c/machine.sh $option $filePath $testType $quantityTest $folderName
            ;;
        "cpp")
            bash machine/c-cpp/cpp/machine.sh $option $filePath $testType $quantityTest $folderName
            ;;
        "java") 
            bash machine/java/machine.sh $option $filePath $testType $quantityTest $folderName
            ;;
        "sh")
            bash machine/shellscript/machine.sh $option $filePath $testType $quantityTest $folderName
            ;;
        "pas")
            bash machine/pascal/machine.sh $option $filePath $testType $quantityTest $folderName
            ;;
        "go")
            bash macine/golang/machine.sh$option $filePath $testType $quantityTest $folderName
            ;;
    esac
}

main() {
    submit
}
main