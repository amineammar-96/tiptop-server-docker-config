## Pour initialiser le backup
```
sudo borg init --encryption=repokey /backup
```
## Creation du script (Sauvegarde)
```
export BORG_PASSPHRASE='votre_mot_de_passe'
docker run --rm -v borg_backup:/backup -v /chemin/vers/vos/donnees-a-sauvegarder:/data borgbackup/borg create /backup::$(date +%Y-%m-%d_%H-%M-%S) /data
```
Assurez-vous de remplacer /chemin/vers/vos/donnees-a-sauvegarder par le chemin de vos données à sauvegarder.

### Rendez le script executable

```
chmod +x backup.sh
```

##  Planification des sauvegardes
Exécutez cette ligne de cmd:
```
sudo crontab -e
```
rajouter cette ligne pour réaliser des backups chaque minuitpar exemple:

0 0 * * * ~/backup/backup.sh

## Verification de la sauvegarde
```
 sudo borg list /backup

```

## Pour supprimer des sauvegarde 
```
borg delete /backup::sauvegarde__2024-04-03_17-41-54
```
