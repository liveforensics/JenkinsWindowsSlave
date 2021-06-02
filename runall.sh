#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}Hello${NC} World"


echo '***********************************************************************************************************************'
echo '*                                                                                                                     *'
echo '*  STARTING ALL THE THINGS                                                                                            *'
echo '*                                                                                                                     *'
echo '*  PULLING LATEST IMAGES                                                                                              *'
echo '*                                                                                                                     *'
echo '***********************************************************************************************************************'

docker pull traefik:latest
docker pull portainer/portainer-ce
docker pull jenkins/jenkins:latest
docker pull sonatype/nexus3

echo ' '
echo '***********************************************************************************************************************'
echo '*                                                                                                                     *'
echo '*   STARTING PORTAINER                                                                                                *'
echo '*                                                                                                                     *'
echo '***********************************************************************************************************************'
cd Swarm
cd portainer
pwd
sh start.sh

echo ' '
echo '***********************************************************************************************************************'
echo '*                                                                                                                     *'
echo '*   STARTING TRAEFIK                                                                                                  *'
echo '*                                                                                                                     *'
echo '***********************************************************************************************************************'
cd ..
cd traefik
pwd
sh setup.sh

echo ' '
echo '***********************************************************************************************************************'
echo '*                                                                                                                     *'
echo '*   STARTING JENKINS AND THE BUILD AGENTS                                                                             *'
echo '*                                                                                                                     *'
echo '***********************************************************************************************************************'
cd ..
cd Builder
pwd
sh start.sh

cd ..
pwd 

echo ' '
echo '***********************************************************************************************************************'
echo '*                                                                                                                     *'
echo '*   EXAMINE DOCKER ENVIRONMENT                                                                                        *'
echo '*                                                                                                                     *'
echo '***********************************************************************************************************************'
docker node ls
sleep 10s
docker service ls