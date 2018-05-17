#!/bin/bash

# CURL Install

echo " --------------------------------------------------------------------- ";
echo " [ ! ]          C A U T I O N!           !C U I D A D O!          [ ! ]";
echo " --------------------------------------------------------------------- ";
echo "";
echo ""THIS SOFTWARE IS PROVIDED \"AS IS\" AND ANY EXPRESSED OR IMPLIED"";
echo "WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES"
echo "OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED."
echo "IN NO EVENT SHALL THE PROJECT MAINTAINERS OR PROJECT CONTRIBUTORS BE"
echo "LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,"
echo "OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF"
echo "SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS"
echo "INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN"
echo "CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)"
echo "ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF"
echo "ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. "
echo "";
echo "";
echo " Installation of this software is subject to your acceptance of"
echo "  these terms."
echo "";
# read: safe shell input check. non-negated answer continues, else aborts.
read -p "Do you accept these terms? (Y/n)" -n 1 -r
echo    # move cursor to a new line
echo ""
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "ABORTING due to user input. The above terms must be accepted in"
    echo "order to proceed with the installation. Now exiting."
    echo "";
    exit 1;
else
    echo "";# leave if statement and continue.
fi
echo "";
echo "";
echo "This script is about to *UPDATE* AND *UPGRADE* your OS. It is highly "
echo "  recommended that you deploy this on a new server, and not an existing"
echo "  one you may already be using. Running upgrades on an existing"
echo "  in-production server may break your environment and pre-existing setup"
echo "  of software, programs, scripts, applications, etc."
echo "";
echo "";
# read: safe shell input check. non-negated answer continues, else aborts.
read -p "Would you like to proceed updating and upgrading your OS and ALL packages? " -n 1 -r
echo    # move cursor to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "";
    echo "";
    echo "ABORTING per user request.";
    echo "";
    echo "";
    exit 1;
else
    echo "";# leave if statement and continue.
fi



sudo yum upgrade -y 1>/dev/null 2>&1
sudo yum install epel-release -y 1>/dev/null 2>&1
sudo yum install dialog git wget vim whiptail -y 1>/dev/null 2>&1
sudo yum upgrade -y 1>/dev/null 2>&1

sudo rm -r /opt/rdisco

sudo git clone https://github.com/kaltec-w/reimagined-disco.git /opt/rdisco

sudo bash /opt/rdisco/menus/main.sh