var gp_num = gamepad_get_device_count();
for (var i = 0; i < gp_num; i++;)
{
    if (global.gp[i])
    {
        if(gamepad_button_check_released(i, gp_face1))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
if (gp_num == 0)
{
    return false;
}

