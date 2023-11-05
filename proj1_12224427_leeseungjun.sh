echo "--------------------------"
echo "User Name: LeeSeungJun"
echo "Student Number: 12224427"
echo "[ MENU ]"
echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
echo "2. Get the data of action genre movies from 'u.item'"
echo "3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'"
echo "4. Delete the 'IMDb URL' from 'u.data'"
echo "5. Get the data about users from 'u.user'"
echo "6. Modify the format of 'release date' in 'u.item'"
echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
echo "9. Exit"
echo "--------------------------"

while true; do
    echo "Enter your choice [ 1- 9 ]"
    read choice
    case $choice in
        1) read -p "Please enter 'movie id' (1~1682): " id; awk -v id="$id" -F\| '$1 == id {print $0}' u.item ;;
        2) read -p "Do you want to get the data of 'action' genre movies from 'u.item'?: " isWant; if [ "$isWant" = "y" ]; then awk -F\| '$7 == 1 {print $1, $2}' u.item; fi ;;
        3) read -p "Please enter the 'movie id' (1~1682): " id; awk -v id="$id" -F"\t" '$2 == id {sum += $3; count++} END {if (count > 0) printf "%.5f\n", sum/count}' u.data ;;
        4) read -p "Do you want to delete the 'IMDB URL' from 'u.item'?: " isWant; if [ "$isWant" = "y" ]; then sed 's|http[^)]*)||g' u.item | head; fi ;;
        5) read -p "Do you want to get the data about users from 'u.user'?: " isWant; if [ "$isWant" = "y" ]; then sed -E 's/([0-9]+)\|([0-9]+)\|(M)\|(.*)\|.*/user \1 is \2 years old male \4/; s/([0-9]+)\|([0-9]+)\|(F)\|(.*)\|.*/user \1 is \2 years old female \4/' u.user | head; fi ;;
	6) read -p "Do you want to Modify the format of 'release data' in 'u.item'?: " isWant; if [ "$isWant" = "y" ]; then awk 'BEGIN{split("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec", month, " "); for(i=1; i<=12; i++) mdigit[month[i]]=i}
             {split($3, date, "-"); printf "%s|%s|%s%02d%02d|%s|%s|", $1, $2, substr(date[3],3,2), mdigit[date[2]], date[1], $4, $5; for(i=6; i<=NF; i++) printf "%s|", $i; printf "\n"}' FS='|' u.item | tail; fi ;;
        7) read -p "Please enter the 'user id' (1~943): " id; awk -v id="$id" 'BEGIN{FS="\t"} $1 == id {print $2}' u.data | sort -n | paste -s -d'|';echo ' ';movie_ids=$(awk -v id="$id" 'BEGIN{FS="\t"} $1 == id {print $2}' u.data | sort -n);echo $movie_ids | tr ' ' '\n' | while read movie_id;do awk -v movie_id="$movie_id" 'BEGIN{FS=OFS="|"} $1 == movie_id {print $1, $2}' u.item;done ;;
	8) read -p "Do you want to get the the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?: " isWant; if [ "$isWant" = "y" ]; then awk -F'|' 'NR==FNR && $2>=20 && $2<=29 && $4=="programmer"{id[$1]=1; next} id[$1] {sum[$2]+=$3; count[$2]++} END {for (i in sum) {avg = sprintf("%.5f", sum[i]/count[i]); sub("\\.?[0]*$", "", avg); print i, avg}}' u.user FS='\t' u.data | sort -n -k1; fi ;;
        9) echo "Bye!"; break ;;
    esac
done
