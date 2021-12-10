for i in $(ls | grep -v test.sh); do
  cd $i
  [[ $(bash part1.sh input) -eq $(cat result_part1) ]] || echo "${i}/part1.sh failed"
  [[ $(bash part2.sh input) -eq $(cat result_part2) ]] || echo "${i}/part2.sh failed"
  cd ..
done
