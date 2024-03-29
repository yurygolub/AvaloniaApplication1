namespace AvaloniaApplication1.ViewModels;

public class MainViewModel : ViewModelBase
{
    private int counter;

    public string Greeting => "Welcome to Avalonia!";

    public string ButtonContent { get; set; } = "Click me";

    public void ButtonClick()
    {
        this.counter++;

        if (this.counter > 1)
        {
            this.ButtonContent = $"You clicked {this.counter} times";
        }
        else
        {
            this.ButtonContent = $"You clicked {this.counter} time";
        }
    }
}
