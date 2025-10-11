import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const date = createPoll("", 1000, "date +'%d %b'")
  const time = createPoll("", 1000, "date +'%H:%M'")
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox orientation={Gtk.Orientation.HORIZONTAL}>
        <menubutton $type="center">
          <label cssName="date" label={date} />
          <popover>
            <Gtk.Calendar />
          </popover>
        </menubutton>
        <label cssName="time" label={time} $type="end" />
      </centerbox>
    </window>
  )
}
