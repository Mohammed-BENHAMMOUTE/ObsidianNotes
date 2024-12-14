[[Design Patterns and Code refactoring]]

## Overview
The Adapter design pattern is a structural design pattern that allows objects with incompatible interfaces to collaborate. It acts as a wrapper between two objects, converting the interface of one object so that it can be used by the other.

## Key Concepts
- Allows incompatible interfaces to work together
- Provides a bridge between two incompatible interfaces
- Follows the principle of "composition over inheritance"

## Structure
1. **Target Interface**: The interface expected by the client code
2. **Adaptee**: An existing class with a different interface
3. **Adapter**: A class that implements the target interface and wraps the adaptee

## Real-World Analogy
Think of a travel power adapter. You have an American electronic device (Adaptee) that uses a different plug type, and you need it to work in a European socket (Target Interface). The power adapter (Adapter) makes this possible by converting the plug.

## Java Implementation Example

```java
// Target Interface
interface MediaPlayer {
    void play(String filename);
}

// Adaptee (Incompatible Interface)
class AdvancedMusicPlayer {
    public void playVlc(String filename) {
        System.out.println("Playing VLC file: " + filename);
    }
    
    public void playMp4(String filename) {
        System.out.println("Playing MP4 file: " + filename);
    }
}

// Adapter Class
class MediaAdapter implements MediaPlayer {
    private AdvancedMusicPlayer advancedMusicPlayer;

    public MediaAdapter(String audioType) {
        this.advancedMusicPlayer = new AdvancedMusicPlayer();
    }

    @Override
    public void play(String filename) {
        if (filename.endsWith(".vlc")) {
            advancedMusicPlayer.playVlc(filename);
        } else if (filename.endsWith(".mp4")) {
            advancedMusicPlayer.playMp4(filename);
        }
    }
}

// Client Implementation
class AudioPlayer implements MediaPlayer {
    private MediaAdapter mediaAdapter;

    @Override
    public void play(String filename) {
        // Built-in support for MP3
        if (filename.endsWith(".mp3")) {
            System.out.println("Playing MP3 file: " + filename);
        } 
        // Using adapter for other formats
        else if (filename.endsWith(".vlc") || filename.endsWith(".mp4")) {
            mediaAdapter = new MediaAdapter(filename);
            mediaAdapter.play(filename);
        } 
        else {
            System.out.println("Unsupported file format: " + filename);
        }
    }
}

// Demonstration Class
public class AdapterPatternDemo {
    public static void main(String[] args) {
        AudioPlayer audioPlayer = new AudioPlayer();

        // Playing different types of audio files
        audioPlayer.play("song.mp3");      // Native support
        audioPlayer.play("movie.vlc");     // Using adapter
        audioPlayer.play("clip.mp4");      // Using adapter
        audioPlayer.play("podcast.wav");   // Unsupported format
    }
}
```

## Alternative Implementation (Class Adapter using Inheritance)
```java
// Using inheritance-based adapter
class MediaPlayerAdapter extends AdvancedMusicPlayer implements MediaPlayer {
    @Override
    public void play(String filename) {
        if (filename.endsWith(".vlc")) {
            playVlc(filename);
        } else if (filename.endsWith(".mp4")) {
            playMp4(filename);
        }
    }
}
```

## Use Cases
- When you want to use an existing class, but its interface doesn't match the one you need
- When you want to create a reusable class that cooperates with unrelated or unforeseen classes
- When you need to integrate new or legacy code into existing systems

## Advantages
- Increases code reusability
- Provides a clean separation of concerns
- Allows working with incompatible interfaces without modifying existing code
- Follows the Open/Closed Principle

## Potential Drawbacks
- Increased complexity of code
- Slight performance overhead due to additional wrapping
- May require creating multiple adapters for complex scenarios

## Conclusion
The Adapter pattern is a powerful solution for making incompatible interfaces work together, providing a flexible way to integrate disparate components in object-oriented design.