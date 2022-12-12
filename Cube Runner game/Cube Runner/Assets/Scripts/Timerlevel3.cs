using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class Timerlevel3 : MonoBehaviour
{
    // set time for level 3.
    private float timeLeft = 30f;
    private Text timerSeconds;

    // calls the Text to display time.
    void Start()
    {
        timerSeconds = GetComponent<Text>();

    }

    //Update function time less than 0 restarts the level.
    private void Update()
    {
        timeLeft -= Time.deltaTime;
        timerSeconds.text = timeLeft.ToString("f0");
        if (timeLeft <= 0)
            Restart();
    }

    void Restart()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }
}
