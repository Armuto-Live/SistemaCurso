<?php
// Ver el ejemplo de password_hash() para ver de dónde viene este hash.
$hash = '$2y$12$MWPfFoqCZShqo3y4E3lEAOdRvkUzB2ZdZwX73.LxBHDlkFL/dVu/G';

if (password_verify('123456', $hash)) {
    echo '¡La contraseña es válida!';
} else {
    echo 'La contraseña no es válida.';
}

    //Esto es la contraseña => $2y$12$MWPfFoqCZShqo3y4E3lEAOdRvkUzB2ZdZwX73.LxBHDlkFL/dVu/G
    //$md5 = password_hash('123456',PASSWORD_DEFAULT,['cost'=>12]);
    //echo $md5;
?>