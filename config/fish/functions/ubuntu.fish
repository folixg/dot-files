# Defined in - @ line 1
function ubuntu --wraps='docker pull folixg/ubuntu:latest && docker run --rm -it -e USER_UID=(id -u) -e USER_GID=(id -g) -v (pwd):/home/folix/workspace folixg/ubuntu' --description 'alias ubuntu docker pull folixg/ubuntu:latest && docker run --rm -it -e USER_UID=(id -u) -e USER_GID=(id -g) -v (pwd):/home/folix/workspace folixg/ubuntu'
  docker pull folixg/ubuntu:latest && docker run --rm -it -e USER_UID=(id -u) -e USER_GID=(id -g) -v (pwd):/home/folix/workspace folixg/ubuntu $argv;
end
