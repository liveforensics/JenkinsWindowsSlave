#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color


echo -e "${YELLOW}***********************************************************************************************************************"
echo -e "*                                                                                                                     *"
echo -e "*  STARTING ALL THE THINGS                                                                                            *"
echo -e "*                                                                                                                     *"
echo -e "*  PULLING LATEST IMAGES                                                                                              *"
echo -e "*                                                                                                                     *"
echo -e "***********************************************************************************************************************${NC}"

docker pull traefik:latest
docker pull portainer/portainer-ce
docker pull jenkins/jenkins:latest
docker pull sonatype/nexus3

echo ' '
echo -e "${YELLOW}***********************************************************************************************************************"
echo -e "*                                                                                                                     *"
echo -e "*   CREATING TESTLAB SWARM NETWORK                                                                                    *"
echo -e "*                                                                                                                     *"
echo -e "***********************************************************************************************************************${NC}"
docker network rm testlab-network
docker network create -d overlay --attachable --scope swarm --subnet 10.12.0.0/16 testlab-network

echo ' '
echo -e "${YELLOW}***********************************************************************************************************************"
echo -e "*                                                                                                                     *"
echo -e "*   STARTING PORTAINER                                                                                                *"
echo -e "*                                                                                                                     *"
echo -e "***********************************************************************************************************************${NC}"
cd Swarm
cd portainer
pwd
sh start.sh

echo ' '
echo -e "${YELLOW}***********************************************************************************************************************"
echo -e "*                                                                                                                     *"
echo -e "*   STARTING TRAEFIK                                                                                                  *"
echo -e "*                                                                                                                     *"
echo -e "***********************************************************************************************************************${NC}"
cd ..
cd traefik
pwd
sh setup.sh

echo ' '
echo -e "${YELLOW}***********************************************************************************************************************"
echo -e "*                                                                                                                     *"
echo -e "*   STARTING JENKINS AND THE BUILD AGENTS                                                                             *"
echo -e "*                                                                                                                     *"
echo -e "***********************************************************************************************************************${NC}"
cd ..
cd Builder
pwd
sh start.sh

cd ..
pwd 

echo ' '
echo -e "${YELLOW}***********************************************************************************************************************"
echo -e "*                                                                                                                     *"
echo -e "*   EXAMINE DOCKER ENVIRONMENT                                                                                        *"
echo -e "*                                                                                                                     *"
echo -e "***********************************************************************************************************************${NC}"
docker node ls
sleep 10s
docker service ls