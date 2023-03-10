# Script Made by: Ruturajn <nanotiruturaj@gmail.com>
pkgname=Config
_pkgname=dots
pkgver=1.0
pkgrel=1
pkgdesc="System Configuration"
arch=('x86_64')
url="https://github.com/jd1t25/${_pkgname}"
license=('GPL')
depends=('git')
provides=('dots')
source=("git+${url}.git")
destdir="/etc/skel/"
md5sums=('SKIP')

package() {
    cd "${_pkgname}"
    mkdir -p "${pkgdir}${destdir}"
    cp -r ../dots/. "${pkgdir}${destdir}"
}

