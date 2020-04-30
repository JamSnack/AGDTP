///scr_activateGame();

//Reactivate objects.
if instance_exists(worldControl)
{
    instance_activate_object(gameControl);
    instance_activate_object(camera);
    instance_activate_object(hudControl);
}
