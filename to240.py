#!/usr/bin/env python3

import os
from mido import MidiFile, MidiTrack, Message

def convert_to_240_ppqn(midi_path, output_path):
    """
    Converts a MIDI file to 240 PPQN and saves it with a new name.

    Args:
        midi_path (str): Path to the input MIDI file.
        output_path (str): Path to save the converted MIDI file.
    """
    try:
        # Load the MIDI file
        mid = MidiFile(midi_path)
        original_ppqn = mid.ticks_per_beat

        if original_ppqn == 240:
            print(f"{midi_path} is already 240 PPQN. Skipping conversion.")
            return

        # Calculate the conversion factor
        conversion_factor = 240 / original_ppqn

        # Create a new MIDI file with the target PPQN
        new_mid = MidiFile(ticks_per_beat=240, type=mid.type)

        # Convert each track
        for track in mid.tracks:
            new_track = MidiTrack()
            new_mid.tracks.append(new_track)

            # Adjust timings for each message
            for msg in track:
                if msg.time > 0:
                    msg = msg.copy(time=int(msg.time * conversion_factor))
                new_track.append(msg)

        # Save the new MIDI file
        new_mid.save(output_path)
        print(f"Converted: {midi_path} -> {output_path}")

    except Exception as e:
        print(f"Error processing {midi_path}: {e}")

def convert_all_midis_to_240_ppqn(directory):
    """
    Converts all MIDI files in the directory to 240 PPQN.

    Args:
        directory (str): Path to the directory containing MIDI files.
    """
    midi_files = [f for f in os.listdir(directory) if f.lower().endswith(('.mid', '.midi'))]
    
    if not midi_files:
        print(f"No MIDI files found in the directory: {directory}")
        return

    for midi_file in midi_files:
        input_path = os.path.join(directory, midi_file)
        output_path = os.path.join(directory, f"c{midi_file}")
        convert_to_240_ppqn(input_path, output_path)

def main():
    current_directory = os.getcwd()
    print(f"Converting all MIDI files in the current directory: {current_directory}")
    convert_all_midis_to_240_ppqn(current_directory)

if __name__ == "__main__":
    main()

