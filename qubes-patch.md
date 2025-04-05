###Qubes Package Development Hell
---
untar source
git init (in root dir)
git add -A
git commit -a -m "Some Message"
git checkout -b SomeName
patch -p1 (in root dir) < /path/to/patch.patch
git commit -a -m "Some Message #2"
**** MAKE CHANGES ****
git commit -a -m "Some Message #3"
git diff master..SomeName > SomePatchName.Patch
mv SomePatchName.Patch /path/to/qubes.folder/
ssh-add /path/to/GithubPrivateKey && git push -u origin


###Building Qubes Packages
---
sudo qubes-dom0-update qubes-template-fedora-DOM0VERNO
**** In new-qube ****
git clone https::/www.github.com/user/repo
**** Make PKG ****
rpmdev-setuptree 
mv {tarball, Patch, Misc Files specified in spec } /path/to/rpmtree/SOURCES/
mv .spec /path/to/rpmtree/SPECS/ 
sudo dnf builddep /path/to/SPECS/.spec
rpmbuild -bb /path/to/rpm/tree/SPECS/.spec
qvm-run --pass-io new-qube 'cat /path/to/x86_64.rpm' > /path/to/dom0/sources/x86_64.rpm
sudo dnf reinstall x86_64.rpm
  
