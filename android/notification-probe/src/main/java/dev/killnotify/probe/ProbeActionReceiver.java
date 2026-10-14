package dev.killnotify.probe;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

public final class ProbeActionReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        int count = context.getSharedPreferences("probe_state", Context.MODE_PRIVATE)
                .getInt("action_count", 0);
        context.getSharedPreferences("probe_state", Context.MODE_PRIVATE)
                .edit().putInt("action_count", count + 1).apply();
        Toast.makeText(context, "Ação sintética original executada.", Toast.LENGTH_SHORT).show();
    }
}
