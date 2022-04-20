#!/bin/bash

clear;

header(){
    clear
    echo "************************************"
    echo -e "********* \033[1;31mWheat Scraping\033[0m ***********"
    echo "************************************"
    echo
}
menu(){
    echo "****************************************************************"
    echo -e "***** \033[1;32m[ 1 ] Springer [ 2 ] Scopus [ 3 ] SciELO [ 4 ] Wiley\033[0m *****"
    echo "****************************************************************"
    echo

    read -r -p 'Opção: ' opc0;

    if [ "$opc0" == 1 ]; then

        cd /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/  || exit;

        echo
        echo -e '\033[1;32m[ 1 ] Euphytica\033[0m'
        echo -e '\033[1;32m[ 2 ] Genetic Resources and Crop Evolution\033[0m'
        echo -e '\033[1;32m[ 3 ] Outra revista\033[0m'
        echo -e '\033[1;32m[ 4 ] Outra revista\033[0m'
        echo

        read -r -p 'Opção: ' opc1;

        if [ "$opc1" == 1 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 2 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/Genetic_Resources_and_Crop_Evolution/main_GRCE.r

        elif [ "$opc1" == 3 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 4 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        fi
    fi

    if [ "$opc0" == 2 ]; then

        cd /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/02.Scopus/  || exit;

        echo
        echo -e '\033[1;32m[ 1 ]Euphytica\033[0m'
        echo -e '\033[1;32m[ 2 ]Outra revista\033[0m'
        echo -e '\033[1;32m[ 3 ]Outra revista\033[0m'
        echo -e '\033[1;32m[ 4 ]Outra revista\033[0m'
        echo

        read -r -p 'Opção: ' opc1;

        if [ "$opc1" == 1 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 2 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 3 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 4 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        fi
    fi

    if [ "$opc0" == 3 ]; then

        cd /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/03.SciELO/  || exit;

        echo
        echo -e '\033[1;32m[ 1 ]Euphytica\033[0m'
        echo -e '\033[1;32m[ 2 ]Outra revista\033[0m'
        echo -e '\033[1;32m[ 3 ]Outra revista\033[0m'
        echo -e '\033[1;32m[ 4 ]Outra revista\033[0m'
        echo

        read -r -p 'Opção: ' opc1;

        if [ "$opc1" == 1 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 2 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 3 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 4 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r
        fi
    fi

    if [ "$opc0" == 4 ]; then

        cd /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/04.Wiley/ || exit;

        echo
        echo -e '\033[1;32m[ 1 ]Euphytica\033[0m'
        echo -e '\033[1;32m[ 2 ]Outra revista\033[0m'
        echo -e '\033[1;32m[ 3 ]Outra revista\033[0m'
        echo -e '\033[1;32m[ 4 ]Outra revista\033[0m'
        echo

        read -r -p 'Opção: ' opc1;

        if [ "$opc1" == 1 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 2 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 3 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        elif [ "$opc1" == 4 ]; then

            Rscript /home/$USER/MEGA/scripts-pessoais/RScripts/wheat_scraping/01.Springer/euphytica/main_euphytica.r

        fi
    fi
}

cont=1
while [ $cont == 1 ];
do
    header;
    menu;

    echo -e "\033[1;31mCONCLUÍDO!\033[0m"
    sleep 0.5
    echo -e '\033[1;32m[ 1 ] Continuar\033[0m'
    echo -e '\033[1;32m[ 2 ] Finalizar\033[0m'
    read -r -p 'Opção: ' cont;
done
exit


